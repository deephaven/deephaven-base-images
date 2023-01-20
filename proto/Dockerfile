# syntax=docker/dockerfile:1.4

# -------------------------------------

FROM golang:1 as go-build

ARG PROTOC_GEN_GO_VERSION=v1.28
ARG PROTOC_GEN_GO_GRPC_VERSION=v1.2

RUN set -eux; \
    go install google.golang.org/protobuf/cmd/protoc-gen-go@${PROTOC_GEN_GO_VERSION}; \
    go install google.golang.org/grpc/cmd/protoc-gen-go-grpc@${PROTOC_GEN_GO_GRPC_VERSION}

# -------------------------------------

FROM node:18-bullseye as protoc-base

ARG DEBIAN_FRONTEND="noninteractive"

RUN --mount=type=bind,source=./01-protoc-base,target=./01-protoc-base ./01-protoc-base/install.sh
COPY --link --from=go-build /go/bin/protoc-gen-go-grpc /opt/protoc-gen-go-grpc
COPY --link --from=go-build /go/bin/protoc-gen-go /opt/protoc-gen-go
COPY --link --from=cpp-client-base ./cpp-client/deps/local/grpc/bin /opt/cpp
