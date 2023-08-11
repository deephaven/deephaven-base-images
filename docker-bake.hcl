group "default" {
    targets = [
        "java",
        "nginx-base",
        "nginx-noroot-base",
        "protoc-base",
        "cpp-client-base",
    ]
}

group "release" {
    targets = [
        "java-release",
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

# User for cpp-client, passed to cmake as build type.
# Typically 'Debug' or 'Release'
# 'Debug' may be conveniennt in some manual/development
# settings, but is considerably more expensive in terms
# of space and also somewhat more expensive in build time.
# So we default to 'Release'.
variable "BUILD_TYPE" {
    default = "Release"
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
    contexts = {
        cpp-client-base = "target:cpp-client-base"
    }
    tags = [ "${REPO_PREFIX}protoc-base:${TAG}" ]
    target = "protoc-base"
}

target "cpp-client-base" {
    context = "cpp-client/"
    tags = [ "${REPO_PREFIX}cpp-client-base:${TAG}" ]
    args = {
        "BUILD_TYPE" = "${BUILD_TYPE}"
    }
}

target "java-release" {
    inherits = [ "java" ]
    platforms = [ "linux/amd64", "linux/arm64" ]
}

target "slim-base-release" {
    inherits = [ "slim-base" ]
    platforms = [ "linux/amd64", "linux/arm64" ]
}

target "server-base-release" {
    inherits = [ "server-base" ]
    platforms = [ "linux/amd64", "linux/arm64" ]
}

target "nltk-base-release" {
    inherits = [ "nltk-base" ]
    platforms = [ "linux/amd64", "linux/arm64" ]
}

target "pytorch-base-release" {
    inherits = [ "pytorch-base" ]
    platforms = [ "linux/amd64", "linux/arm64" ]
}

target "sklearn-base-release" {
    inherits = [ "sklearn-base" ]
    platforms = [ "linux/amd64", "linux/arm64" ]
}

target "tensorflow-base-release" {
    inherits = [ "tensorflow-base" ]
    platforms = [ "linux/amd64" ]
}

target "all-ai-base-release" {
    inherits = [ "all-ai-base" ]
    platforms = [ "linux/amd64" ]
}

target "nginx-base-release" {
    inherits = [ "nginx-base" ]
    platforms = [ "linux/amd64", "linux/arm64" ]
}

target "nginx-noroot-base-release" {
    inherits = [ "nginx-noroot-base" ]
    platforms = [ "linux/amd64", "linux/arm64" ]
}

target "protoc-base-release" {
    inherits = [ "protoc-base" ]
    platforms = [ "linux/amd64" ]
}

target "cpp-client-base-release" {
    inherits = [ "cpp-client-base" ]
    platforms = [ "linux/amd64" ]
}
