group "default" {
    targets = [
        "protoc-base",
        "cpp-client-base",
    ]
}

group "release" {
    targets = [
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
