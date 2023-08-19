# base-images

This repository is responsible for producing non-"server" images for use with [deephaven-core](https://github.com/deephaven/deephaven-core). The server-specific `-base` image building process has moved to [deephaven-server-docker](https://github.com/deephaven/deephaven-server-docker).

## Development images

### protoc-base

Based on `node:18-bullseye`, installs support for JS, python, and java protoc generation.

Produced (only) for platform amd64.

### cpp-client-base

Based on `debian:bullseye`, installs libraries needed to build the Deephaven cpp client.

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
