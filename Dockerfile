FROM golang:1.23 AS builder

WORKDIR /app

COPY go.mod ./
COPY main.go ./
COPY templates ./templates

RUN CGO_ENABLED=0 go build -o bandname-app .

FROM scratch

WORKDIR /app

COPY --from=builder /app/bandname-app /app/bandname-app
COPY --from=builder /app/templates /app/templates

CMD ["/app/bandname-app"]