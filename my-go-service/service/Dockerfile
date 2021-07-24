FROM golang:1.16-alpine as builder

RUN mkdir -p /my-go-service

WORKDIR /my-go-service

COPY . .

RUN go mod download

RUN CGO_ENABLED=0 go build -o bin/my-go-service

FROM alpine:3.13

RUN addgroup -S app \
    && adduser -S -G app app \
    && apk --no-cache add \
    ca-certificates curl netcat-openbsd

WORKDIR /home/app

COPY --from=builder /my-go-service/bin/my-go-service .
RUN chown -R app:app ./

USER app

CMD ["./my-go-service"]