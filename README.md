# base-images

This repository is responsible for producing a set of images for use with [deephaven-core](https://github.com/deephaven/deephaven-core).

## Server images

Note: some of this documentation may be out of date. The server-specific `-base` image building process has moved to [deephaven-server-docker](https://github.com/deephaven/deephaven-server-docker).

### java

Based on `debian:buster-slim`, installs OpenJDK 11.

Produced for platforms amd64 and arm64.

### slim-base

Based on `java`, installs liblzo2 and grpc_health_probe.

Used as the base image for [deephaven-core's](https://github.com/deephaven/deephaven-core) `ghcr.io/deephaven/server-slim` image.

Produced for platforms amd64 and arm64.

### server-base

Based on `slim-base`, installs python 3.7 runtime libraries and Deephaven python requirements.
Sets up and defaults to the virtual environment `/opt/deephaven-venv`.

Used as the base image for [deephaven-core's](https://github.com/deephaven/deephaven-core) `ghcr.io/deephaven/server` image.

Produced for platforms amd64 and arm64.

## Web images

### nginx-base

Based on `nginx:1.19`, installs requirements for webdav class 2 support.

Used as the base image for [deephaven-core's](https://github.com/deephaven/deephaven-core) `ghcr.io/deephaven/web` image.

Produced for platforms amd64 and arm64.

## Development images

### python-dev-base

Based on `slim-base`, installs python 3.7 runtime and development libraries.
Sets up and defaults to the virtual environment `/opt/build-venv`.

Used as the base image for building jpy for [deephaven-core](https://github.com/deephaven/deephaven-core).
There are nice sympathies when building jpy on a system derived from the runtime image.

Produced for platforms amd64 and arm64.

### protoc-base

Based on `node:14-buster-slim`, installs support for JS, python, and java protoc generation.

Produced (only) for platform amd64.

### cpp-client-base

Based on `ubuntu:22.04`, installs libraries needed to build the Deephaven cpp client.

Produced (only) for platform amd64.

## Extra server images

The following are extended base runtimes for [deephaven-core](https://github.com/deephaven/deephaven-core).

### nltk-base

Based on `server-base`, installs the [Natural Language Toolkit](https://github.com/nltk/nltk) requirements.

Used as the base image for [deephaven-core's](https://github.com/deephaven/deephaven-core) `ghcr.io/deephaven/server-nltk` image.

Produced for platforms amd64 and arm64.

### pytorch-base

Based on `server-base`, installs [PyTorch](https://github.com/pytorch/pytorch) requirements.

Used as the base image for [deephaven-core's](https://github.com/deephaven/deephaven-core) `ghcr.io/deephaven/server-pytorch` image.

Produced for platforms amd64 and arm64.

### sklearn-base

Based on `server-base`, installs [scikit-learn](https://github.com/scikit-learn/scikit-learn) requirements.

Used as the base image for [deephaven-core's](https://github.com/deephaven/deephaven-core) `ghcr.io/deephaven/server-sklearn` image.

Produced for platforms amd64 and arm64.

### tensorflow-base

Based on `server-base`, installs [Tensorflow](https://github.com/tensorflow/tensorflow) requirements.

Used as the base image for [deephaven-core's](https://github.com/deephaven/deephaven-core) `ghcr.io/deephaven/server-tensorflow` image.

Produced (only) for platform amd64.

### all-ai-base

Based on `server-base`, installs [Natural Language Toolkit](https://github.com/nltk/nltk), [PyTorch](https://github.com/pytorch/pytorch), [scikit-learn](https://github.com/scikit-learn/scikit-learn), and [Tensorflow](https://github.com/tensorflow/tensorflow) requirements.

Used as the base image for [deephaven-core's](https://github.com/deephaven/deephaven-core) `ghcr.io/deephaven/server-all-ai` image.

Produced (only) for platform amd64.

## Build

For a default, local-only build on your system's platform, run:

```sh
docker buildx bake
```

Release builds should typically be done from CI.

To see the context for the build, you can run:

```sh
docker buildx bake --print default
```

or 

```sh
docker buildx bake --print release
```
