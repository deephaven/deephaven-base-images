group "default" {
    targets = [
        "java",
        "slim-base",
        "server-base",
        "nltk-base",
        "pytorch-base",
        "sklearn-base",
        "tensorflow-base",
        "all-ai-base",
        "nginx-base",
        "nginx-noroot-base",
        "protoc-base",
        "cpp-client-base",
    ]
}

group "release" {
    targets = [
        "java-release",
        "slim-base-release",
        "server-base-release",
        "nltk-base-release",
        "pytorch-base-release",
        "sklearn-base-release",
        "tensorflow-base-release",
        "all-ai-base-release",
        "nginx-base-release",
        "nginx-noroot-base-release",
        "protoc-base-release",
        "cpp-client-base-release",
    ]
}

variable "REPO_PREFIX" {
    default = "ghcr.io/deephaven/"
}

variable "CACHE_PREFIX" {
    default = "deephaven-base-images-2-"
}

variable "TAG" {
    default = "latest"
}

target "java" {
    context = "server/"
    tags = [ "${REPO_PREFIX}java:${TAG}" ]
    target = "java"
}

target "slim-base" {
    context = "server/"
    tags = [ "${REPO_PREFIX}slim-base:${TAG}" ]
    target = "slim-base"
}

target "server-base" {
    context = "server/"
    tags = [ "${REPO_PREFIX}server-base:${TAG}" ]
    target = "server-base"
}

target "nltk-base" {
    context = "server/"
    tags = [ "${REPO_PREFIX}nltk-base:${TAG}" ]
    target = "nltk-base"
}

target "pytorch-base" {
    context = "server/"
    tags = [ "${REPO_PREFIX}pytorch-base:${TAG}" ]
    target = "pytorch-base"
}

target "sklearn-base" {
    context = "server/"
    tags = [ "${REPO_PREFIX}sklearn-base:${TAG}" ]
    target = "sklearn-base"
}

target "tensorflow-base" {
    context = "server/"
    tags = [ "${REPO_PREFIX}tensorflow-base:${TAG}" ]
    target = "tensorflow-base"
}

target "all-ai-base" {
    context = "server/"
    tags = [ "${REPO_PREFIX}all-ai-base:${TAG}" ]
    target = "all-ai-base"
}

target "nginx-base" {
    context = "web/"
    tags = [ "${REPO_PREFIX}nginx-base:${TAG}" ]
    target = "nginx-base"
}

target "nginx-noroot-base" {
    context = "web/"
    tags = [ "${REPO_PREFIX}nginx-noroot-base:${TAG}" ]
    target = "nginx-noroot-base"
}

target "protoc-base" {
    context = "proto/"
    tags = [ "${REPO_PREFIX}protoc-base:${TAG}" ]
    target = "protoc-base"
}

target "cpp-client-base" {
    context = "cpp-client/"
    tags = [ "${REPO_PREFIX}cpp-client-base:${TAG}" ]
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
    platforms = [ "linux/amd64", "linux/arm64" ]
}

target "pytorch-base-release" {
    inherits = [ "pytorch-base" ]
    cache-from = [ "type=gha,scope=${CACHE_PREFIX}pytorch-base" ]
    cache-to = [ "type=gha,mode=max,scope=${CACHE_PREFIX}pytorch-base" ]
    platforms = [ "linux/amd64", "linux/arm64" ]
}

target "sklearn-base-release" {
    inherits = [ "sklearn-base" ]
    cache-from = [ "type=gha,scope=${CACHE_PREFIX}sklearn-base" ]
    cache-to = [ "type=gha,mode=max,scope=${CACHE_PREFIX}sklearn-base" ]
    platforms = [ "linux/amd64", "linux/arm64" ]
}

target "tensorflow-base-release" {
    inherits = [ "tensorflow-base" ]
    cache-from = [ "type=gha,scope=${CACHE_PREFIX}tensorflow-base" ]
    cache-to = [ "type=gha,mode=max,scope=${CACHE_PREFIX}tensorflow-base" ]
    platforms = [ "linux/amd64" ]
}

target "all-ai-base-release" {
    inherits = [ "all-ai-base" ]
    cache-from = [ "type=gha,scope=${CACHE_PREFIX}all-ai-base" ]
    cache-to = [ "type=gha,mode=max,scope=${CACHE_PREFIX}all-ai-base" ]
    platforms = [ "linux/amd64" ]
}

target "nginx-base-release" {
    inherits = [ "nginx-base" ]
    cache-from = [ "type=gha,scope=${CACHE_PREFIX}nginx-base" ]
    cache-to = [ "type=gha,mode=max,scope=${CACHE_PREFIX}nginx-base" ]
    platforms = [ "linux/amd64", "linux/arm64" ]
}

target "nginx-noroot-base-release" {
    inherits = [ "nginx-noroot-base" ]
    cache-from = [ "type=gha,scope=${CACHE_PREFIX}nginx-noroot-base" ]
    cache-to = [ "type=gha,mode=max,scope=${CACHE_PREFIX}nginx-noroot-base" ]
    platforms = [ "linux/amd64", "linux/arm64" ]
}

target "protoc-base-release" {
    inherits = [ "protoc-base" ]
    cache-from = [ "type=gha,scope=${CACHE_PREFIX}protoc-base" ]
    cache-to = [ "type=gha,mode=max,scope=${CACHE_PREFIX}protoc-base" ]
    platforms = [ "linux/amd64" ]
}

target "cpp-client-base-release" {
    inherits = [ "cpp-client-base" ]
    cache-from = [ "type=gha,scope=${CACHE_PREFIX}cpp-client-base" ]
    cache-to = [ "type=gha,mode=max,scope=${CACHE_PREFIX}cpp-client-base" ]
    platforms = [ "linux/amd64" ]
}
