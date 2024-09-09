# syntax=docker/dockerfile:1.4

# -------------------------------------

FROM cpp-client-base as protoc-base

ARG DEBIAN_FRONTEND="noninteractive"
ARG PROTOC_GEN_GO_VERSION=v1.28
ARG PROTOC_GEN_GO_GRPC_VERSION=v1.2
ARG PROTOC_GEN_DOC_VERSION=v1.5.1

ENV GOPATH=/opt/go

RUN set -eux; \
    mkdir -p ${GOPATH}; \
    apt-get -qq update; \
    apt-get -qq -y --no-install-recommends install \
      golang \
      nodejs \
      npm \
      ; \
    go install google.golang.org/protobuf/cmd/protoc-gen-go@${PROTOC_GEN_GO_VERSION}; \
    go install google.golang.org/grpc/cmd/protoc-gen-go-grpc@${PROTOC_GEN_GO_GRPC_VERSION}; \
    go install github.com/pseudomuto/protoc-gen-doc/cmd/protoc-gen-doc@${PROTOC_GEN_DOC_VERSION}

RUN --mount=type=bind,source=./01-protoc-base,target=./01-protoc-base ./01-protoc-base/install.sh
