// Package server contains http server related components
package server

import (
	"context"
	"net/http"
	"os"
	"os/signal"
	"strconv"
	"syscall"
	"time"

	"github.com/gin-gonic/gin"
	"github.com/rs/zerolog/log"
)

const (
	shutdownGracePeriod = 10
)

// Server is a gin web server
type Server struct {
	port      int
	terminate chan os.Signal
}

// NewServer builds a new server instance
func NewServer(terminate chan os.Signal, port int) *Server {
	return &Server{
		port:      port,
		terminate: terminate,
	}
}

// Start will start the application server
func (s *Server) Start() error {
	r := gin.Default()

	r.GET("/health", s.healthHandler)

	srv := &http.Server{
		Addr:    ":" + strconv.Itoa(s.port),
		Handler: r,
	}

	// graceful shutdown
	go s.gracefulShutdown(srv)

	log.Info().Msg("starting server on " + strconv.Itoa(s.port))
	err := srv.ListenAndServe()
	if err != http.ErrServerClosed {
		return err
	}

	return nil
}

func (s *Server) healthHandler(c *gin.Context) {
	c.JSON(http.StatusOK, gin.H{
		"status": "OK",
	})
}

// wait for interrupt signal to gracefully shutdown the server with a timeout of *shutdownGracePeriod* seconds.
func (s *Server) gracefulShutdown(srv *http.Server) {
	signal.Notify(s.terminate, os.Interrupt, syscall.SIGTERM)
	<-s.terminate

	log.Info().Msg("received interrupt signal, gracefully shutting down server")

	ctx, cancel := context.WithTimeout(context.Background(), shutdownGracePeriod*time.Second)
	defer cancel()
	if err := srv.Shutdown(ctx); err != nil {
		log.Fatal().Err(err).Msg("error during server shutdown")
	}
}
