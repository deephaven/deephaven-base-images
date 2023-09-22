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

#
# BEGIN cpp-client specific variables
#

# Passed to cmake as CMAKE_BUILD_TYPE
# Typically 'Debug','Release', or 'RelWithDebInfo'.
# 'Debug' may be convenient in some manual/development
# settings, but is considerably more expensive in terms
# of space and also somewhat more expensive in build time.
# So we default to 'Release'.
variable "BUILD_TYPE" {
    default = "Release"
}

#
# The base distribution to use for the build.
# Examples: 'fedora', 'ubuntu', 'registry.access.redhat.com/ubi8/ubi-minimal'
#
variable "DISTRO_BASE" {
    default = "ubuntu"
}

# A short string to identify the base distribution
# in conditional code in the Dockerfile.
# Examples: 'fedora', 'ubuntu', 'ubi'
variable "DISTRO_BASE_SHORT" {
    default = "ubuntu"
}

# The version tag of the DISTRO_BASE to use.
# Examples: '22.04' (for ubuntu), '38' (for fedora) '8.8' (for ubi).
variable "DISTRO_VERSION" {
    default = "22.04"
}

# The CMAKE_INSTALL_PREFIX for the libraries being built.
variable "PREFIX" {
    default = "/opt/deephaven"
}

#
# END cpp-client specific variables.
#

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
        "DISTRO_BASE" = "${DISTRO_BASE}"
        "DISTRO_BASE_SHORT" = "${DISTRO_BASE_SHORT}"
        "DISTRO_VERSION" = "${DISTRO_VERSION}"
        "PREFIX" = "${PREFIX}"
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
