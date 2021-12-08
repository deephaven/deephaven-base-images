group "default" {
    targets = [
        "java",
        "slim-base",
        "python-dev-base",
        "server-base",
        "nltk-base",
        "pytorch-base",
        "sklearn-base",
        "tensorflow-base"
    ]
}

group "release" {
    targets = [
        "java-release",
        "slim-base-release",
        "python-dev-base-release",
        "server-base-release",
        "nltk-base-release",
        "pytorch-base-release",
        "sklearn-base-release",
        "tensorflow-base-release"
    ]
}

variable "REPO_PREFIX" {
    default = "ghcr.io/deephaven/"
}

variable "CACHE_PREFIX" {
    default = "deephaven-base-images-"
}

variable "TAG" {
    default = "latest"
}

target "java" {
    context = "docker/"
    tags = [ "${REPO_PREFIX}java:${TAG}" ]
    target = "java"
}

target "slim-base" {
    context = "docker/"
    tags = [ "${REPO_PREFIX}slim-base:${TAG}" ]
    target = "slim-base"
}

target "python-dev-base" {
    context = "docker/"
    tags = [ "${REPO_PREFIX}python-dev-base:${TAG}" ]
    target = "python-dev-base"
}

target "server-base" {
    context = "docker/"
    tags = [ "${REPO_PREFIX}server-base:${TAG}" ]
    target = "server-base"
}

target "nltk-base" {
    context = "docker/"
    tags = [ "${REPO_PREFIX}nltk-base:${TAG}" ]
    target = "nltk-base"
}

target "pytorch-base" {
    context = "docker/"
    tags = [ "${REPO_PREFIX}pytorch-base:${TAG}" ]
    target = "pytorch-base"
}

target "sklearn-base" {
    context = "docker/"
    tags = [ "${REPO_PREFIX}sklearn-base:${TAG}" ]
    target = "sklearn-base"
}

target "tensorflow-base" {
    context = "docker/"
    tags = [ "${REPO_PREFIX}tensorflow-base:${TAG}" ]
    target = "tensorflow-base"
}

target "java-release" {
    inherits = [ "java" ]
    cache-from = [ "type=gha,scope=${CACHE_PREFIX}java" ]
    cache-to = [ "type=gha,mode=max,scope=${CACHE_PREFIX}java" ]
    platforms = [ "linux/amd64", "linux/arm64" ]
}

target "slim-base-release" {
    inherits = [ "slim-base" ]
    cache-from = [ "type=gha,scope=${CACHE_PREFIX}slim-base" ]
    cache-to = [ "type=gha,mode=max,scope=${CACHE_PREFIX}slim-base" ]
    platforms = [ "linux/amd64", "linux/arm64" ]
}

target "python-dev-base-release" {
    inherits = [ "python-dev-base" ]
    cache-from = [ "type=gha,scope=${CACHE_PREFIX}python-dev-base" ]
    cache-to = [ "type=gha,mode=max,scope=${CACHE_PREFIX}python-dev-base" ]
    platforms = [ "linux/amd64", "linux/arm64" ]
}

target "server-base-release" {
    inherits = [ "server-base" ]
    cache-from = [ "type=gha,scope=${CACHE_PREFIX}server-base" ]
    cache-to = [ "type=gha,mode=max,scope=${CACHE_PREFIX}server-base" ]
    platforms = [ "linux/amd64", "linux/arm64" ]
}

target "nltk-base-release" {
    inherits = [ "nltk-base" ]
    cache-from = [ "type=gha,scope=${CACHE_PREFIX}nltk-base" ]
    cache-to = [ "type=gha,mode=max,scope=${CACHE_PREFIX}nltk-base" ]
    platforms = [ "linux/amd64" ]
}

target "pytorch-base-release" {
    inherits = [ "pytorch-base" ]
    cache-from = [ "type=gha,scope=${CACHE_PREFIX}pytorch-base" ]
    cache-to = [ "type=gha,mode=max,scope=${CACHE_PREFIX}pytorch-base" ]
    platforms = [ "linux/amd64" ]
}

target "sklearn-base-release" {
    inherits = [ "sklearn-base" ]
    cache-from = [ "type=gha,scope=${CACHE_PREFIX}sklearn-base" ]
    cache-to = [ "type=gha,mode=max,scope=${CACHE_PREFIX}sklearn-base" ]
    platforms = [ "linux/amd64" ]
}

target "tensorflow-base-release" {
    inherits = [ "tensorflow-base" ]
    cache-from = [ "type=gha,scope=${CACHE_PREFIX}tensorflow-base" ]
    cache-to = [ "type=gha,mode=max,scope=${CACHE_PREFIX}tensorflow-base" ]
    platforms = [ "linux/amd64" ]
}
