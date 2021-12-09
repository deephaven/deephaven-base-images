# syntax=docker/dockerfile:1.3

# -------------------------------------

FROM node:14-buster-slim as protoc-base

ARG DEBIAN_FRONTEND="noninteractive"

RUN --mount=type=bind,source=./01-protoc-base,target=./01-protoc-base ./01-protoc-base/install.sh
