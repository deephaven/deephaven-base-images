# syntax=docker/dockerfile:1.3

# -------------------------------------

# Basing off of the perl variant, as our follow-up install would otherwise install perl itself
FROM nginx:1.19-perl as nginx-base

ARG DEBIAN_FRONTEND="noninteractive"

RUN --mount=type=bind,source=./01-nginx-base,target=./01-nginx-base ./01-nginx-base/install.sh
