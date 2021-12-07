# syntax=docker/dockerfile:1.3

# -------------------------------------

# Using buster to ensure python3.7 is available downstream for python

FROM debian:buster-slim as java
RUN --mount=type=bind,source=./01-java,target=./01-java ./01-java/install.sh
ARG TARGETARCH
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

FROM python-base-internal as server-base
RUN --mount=type=bind,source=./04-server-base,target=./04-server-base ./04-server-base/install.sh

# -------------------------------------

FROM server-base as nltk-base
RUN --mount=type=bind,source=./05-nltk-base,target=./05-nltk-base ./05-nltk-base/install.sh

FROM server-base as pytorch-base
RUN --mount=type=bind,source=./05-pytorch-base,target=./05-pytorch-base ./05-pytorch-base/install.sh

FROM server-base as sklearn-base
RUN --mount=type=bind,source=./05-sklearn-base,target=./05-sklearn-base ./05-sklearn-base/install.sh

FROM server-base as tensorflow-base
RUN --mount=type=bind,source=./05-tensorflow-base,target=./05-tensorflow-base ./05-tensorflow-base/install.sh

# -------------------------------------
