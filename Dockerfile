# Compile stage
FROM golang:1.14.4-alpine AS builder

# The latest alpine images don't have some tools like (`git` and `bash`).
# Adding git, bash and openssh to the image
# RUN apk add --no-cache git=2.24.3-r0 \
#     --repository http://mirrors.aliyun.com/alpine/v3.11/community \
#     --repository http://mirrors.aliyun.com/alpine/v3.11/main

# set the basic env variable
ENV GO111MODULE=on \
    CGO_ENABLED=0 \
    GOOS=linux \
    GOARCH=amd64 \
    GOPROXY="https://goproxy.io,direct"

# define the workdir
WORKDIR /app

# copy the source code and the package control file
COPY go.mod main.go ./
# download the dependence and build the source
RUN go mod download && \
  CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build  -ldflags="-s -w" -o /app/bin/app /app/main.go


FROM alpine:latest

ARG version

ENV version=${version}

RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories && \
  echo http://dl-cdn.alpinelinux.org/alpine/edge/testing >> /etc/apk/repositories && \
  apk --no-cache add ca-certificates && \
  apk add tzdata && cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && \
  echo "Asia/Shanghai" > /etc/timezone && \
  mkdir -p /app/logs

WORKDIR /app

COPY --from=builder /app/bin/app /app/
# Copy the Pre-built binary file from the previous stage

# Command to run the executable
ENTRYPOINT ["/app/app"]
CMD []