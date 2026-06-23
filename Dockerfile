FROM golang:1.24-bookworm

WORKDIR /app

RUN apt-get update && apt-get install -y \
    gcc \
    libc6-dev \
    sqlite3 \
    libsqlite3-dev \
    && rm -rf /var/lib/apt/lists/*

COPY whatsapp-bridge/go.mod whatsapp-bridge/go.sum ./
RUN go mod download

COPY whatsapp-bridge/ .

RUN CGO_ENABLED=1 GOOS=linux go build -o /whatsapp-bridge .

EXPOSE 8080

CMD ["/whatsapp-bridge"]
