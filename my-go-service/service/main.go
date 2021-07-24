package main

import (
	"os"
	"strconv"

	"github.com/flare-community/my-go-service/internal/server"
	"github.com/rs/zerolog/log"
)

const defaultPort = 8080

func main() {
	arguments := os.Args[1:]
	serverPort := defaultPort

	if len(arguments) > 0 {
		val, err := strconv.Atoi(arguments[0])
		if err != nil {
			log.Err(err).Msg("cannot start server")
		}

		serverPort = val
	}

	srv := server.NewServer(make(chan os.Signal), serverPort)

	if err := srv.Start(); err != nil {
		log.Err(err).Msg("cannot start server")
	}
}
