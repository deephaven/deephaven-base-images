# syntax=docker/dockerfile:1.3

# -------------------------------------

FROM nginx:1.19 as nginx-base

ARG DEBIAN_FRONTEND="noninteractive"

RUN --mount=type=bind,source=./01-nginx-base,target=./01-nginx-base ./01-nginx-base/install.sh
