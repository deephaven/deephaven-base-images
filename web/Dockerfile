# syntax=docker/dockerfile:1.4

# -------------------------------------

FROM nginx:1.19 as nginx-base

ARG DEBIAN_FRONTEND="noninteractive"

RUN --mount=type=bind,source=./01-nginx-base,target=./01-nginx-base ./01-nginx-base/install.sh

FROM nginxinc/nginx-unprivileged:1.19.7-amd64 as nginx-noroot-base

USER 0
ARG DEBIAN_FRONTEND="noninteractive"
RUN --mount=type=bind,source=./01-nginx-noroot-base,target=./01-nginx-noroot-base ./01-nginx-noroot-base/install.sh
# nginx user gets uid 101, from nginx-unprivileged
USER 101