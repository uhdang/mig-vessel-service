FROM golang:1.9.0 as builder

WORKDIR /go/src/github.com/uhdang/mig-vessel-service

COPY . .

RUN go get
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo


FROM alpine:latest

RUN apk --no-cache add ca-certificates

RUN mkdir /app
WORKDIR /app
COPY --from=builder /go/src/github.com/uhdang/mig-vessel-service .

CMD ["./mig-vessel-service"]
