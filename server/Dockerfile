# syntax=docker/dockerfile:1.3

# -------------------------------------

# Using buster to ensure python3.7 is available downstream for python

FROM debian:buster-slim as java

ARG TARGETARCH
ARG DEBIAN_FRONTEND="noninteractive"

RUN --mount=type=bind,source=./01-java,target=./01-java ./01-java/install.sh
ENV LANG='en_US.UTF-8' \
   LANGUAGE='en_US:en' \
   LC_ALL='en_US.UTF-8' \
   JAVA_HOME=/usr/lib/jvm/java-11-openjdk-${TARGETARCH}

# -------------------------------------

FROM java as slim-base
RUN --mount=type=bind,source=./02-slim-base,target=./02-slim-base ./02-slim-base/install.sh

# -------------------------------------

FROM slim-base as python-base-internal
RUN --mount=type=bind,source=./03-python-base,target=./03-python-base ./03-python-base/install.sh

# -------------------------------------

FROM python-base-internal as python-dev-base
RUN --mount=type=bind,source=./04-python-dev-base,target=./04-python-dev-base ./04-python-dev-base/install.sh
ENV VIRTUAL_ENV='/opt/build-venv' \
   PATH="/opt/build-venv/bin:${PATH}"

FROM python-base-internal as server-base
RUN --mount=type=bind,source=./04-server-base,target=./04-server-base ./04-server-base/install.sh
ENV VIRTUAL_ENV='/opt/deephaven-venv' \
   PATH="/opt/deephaven-venv/bin:${PATH}"

# -------------------------------------

FROM server-base as nltk-base
RUN --mount=type=bind,source=./05-nltk-base,target=./05-nltk-base ./05-nltk-base/install.sh

FROM server-base as pytorch-base
RUN --mount=type=bind,source=./05-pytorch-base,target=./05-pytorch-base ./05-pytorch-base/install.sh

FROM server-base as sklearn-base
RUN --mount=type=bind,source=./05-sklearn-base,target=./05-sklearn-base ./05-sklearn-base/install.sh

FROM server-base as tensorflow-base
RUN --mount=type=bind,source=./05-tensorflow-base,target=./05-tensorflow-base ./05-tensorflow-base/install.sh

FROM server-base as all-ai-base
RUN --mount=type=bind,source=./05-all-ai-base,target=./05-all-ai-base ./05-all-ai-base/install.sh

# -------------------------------------
