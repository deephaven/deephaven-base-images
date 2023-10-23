# syntax=docker/dockerfile:1.4

ARG IMAGE_BASE=ghcr.io/deephaven/cpp-client-base
ARG IMAGE_TAG=latest
FROM ${IMAGE_BASE}:${IMAGE_TAG}
ARG DISTRO_BASE_SHORT=ubuntu
ARG DEBIAN_FRONTEND="noninteractive"
ARG PREFIX=/opt/deephaven

#
# Ubuntu base python install.
#
RUN set -eux; \
    [ "${DISTRO_BASE_SHORT}" = "ubuntu" ] || exit 0; \
    apt-get -qq update; \
    apt-get -qq -y --no-install-recommends install \
        python3.10-dev \
        python3.10-venv \
        python3-pip; \
    rm -fr /var/lib/apt/lists/*

#
# Fedora and RHEL base python install.
#
RUN set -eux; \
    [ "${DISTRO_BASE_SHORT}" = "fedora" ] || \
      [ "${DISTRO_BASE_SHORT}" = "ubi" ] || \
      exit 0; \
    DNF=`type microdnf >/dev/null 2>&1 && echo 'microdnf --disableplugin=subscription-manager' || echo 'dnf -q'`; \
    $DNF -y update; \
    $DNF -y install \
        python3.10-devel \
        python3-pip; \
    $DNF clean all

#
# Python pip installs
#
RUN set -eux; \
    python3 -m pip install --upgrade pip; \
    python3 -m pip install unittest-xml-reporting; \
    python3 -m pip install cython

#
# Ubuntu base R install.
#
RUN set -eux; \
    [ "${DISTRO_BASE_SHORT}" = "ubuntu" ] || exit 0; \
    apt-get -qq update; \
    apt-get -qq -y --no-install-recommends install \
        wget \
        gpg; \
    wget -qO- https://cloud.r-project.org/bin/linux/ubuntu/marutter_pubkey.asc | \
       gpg --dearmor -o /usr/share/keyrings/r-project.gpg; \
    echo "deb [signed-by=/usr/share/keyrings/r-project.gpg] https://cloud.r-project.org/bin/linux/ubuntu jammy-cran40/" | \
       tee -a /etc/apt/sources.list.d/r-project.list; \
    apt-get -qq update; \
    apt-get -qq -y install r-base r-recommended libxml2-dev; \
    rm -fr /var/lib/apt/lists/*

#
# Fedora base R installs.
#
RUN set -eux; \
    [ "${DISTRO_BASE_SHORT}" = "fedora" ] || exit 0; \
    dnf -q -y update; \
    dnf -q -y install R libxml2-devel; \
    dnf clean all

#
# RHEL base R installs.
# This is a hodgepodge of base rpms, packages from epel forced to be installed without dependencies,
# and some libraries compiled from github source at a specific version.
#
RUN set -eux; \
    [ "${DISTRO_BASE_SHORT}" = "ubi" ] || exit 0; \
    DNF=`type microdnf >/dev/null 2>&1 && echo 'microdnf --disableplugin=subscription-manager' || echo 'dnf -q'`; \
    URL_BASE="https://dl.fedoraproject.org/pub/epel/8/Everything/x86_64/Packages"; \
    $DNF -y update; \
    $DNF -y install \
      tcl \
      tk \
      libquadmath \
      libgfortran \
      zip \
      bzip2 \
      which \
      redhat-rpm-config \
      libxml2-devel \
      ; \
    $DNF clean all; \
    rpm -Uvh "${URL_BASE}/t/tre-common-0.8.0-27.20140228gitc2f5d13.el8.noarch.rpm"; \
    rpm -Uvh "${URL_BASE}/t/tre-0.8.0-27.20140228gitc2f5d13.el8.x86_64.rpm"; \
    rpm -Uvh --nodeps "${URL_BASE}/r/R-core-devel-4.3.1-1.el8.x86_64.rpm"; \
    rpm -Uvh --nodeps "${URL_BASE}/r/R-devel-4.3.1-1.el8.x86_64.rpm"; \
    rpm -Uvh --nodeps "${URL_BASE}/r/R-core-4.3.1-1.el8.x86_64.rpm"; \
    rpm -Uvh "${URL_BASE}/r/R-Rcpp-1.0.11-3.el8.x86_64.rpm"; \
    rpm -Uvh "${URL_BASE}/r/R-Rcpp-devel-1.0.11-3.el8.x86_64.rpm"; \
    cd ${PREFIX}/src; \
    git -c advice.detachedHead=false clone -b v0.3.24 https://github.com/OpenMathLib/OpenBLAS.git; \
    cd OpenBLAS; \
    . "${PREFIX}/env.sh"; \
    make -j${NCPUS}  2>&1 | gzip > make.log.gz; \
    make -j${NCPUS} install PREFIX="${PREFIX}" | gzip > make-install.log; \
    cd ..; \
    rm -fr OpenBLAS; \
    ln -s "${PREFIX}/lib/libopenblas.so.0" "${PREFIX}/lib/libopenblaso.so.0"; \
    git -c advice.detachedHead=false clone -b release-60-3 https://github.com/unicode-org/icu.git; \
    cd icu; \
    mkdir icu4c-build; \
    cd icu4c-build; \
    ../icu4c/source/runConfigureICU Linux --prefix="${PREFIX}" 2>&1 | gzip > configure.out.gz; \
    make -j32 install 2>&1 | gzip > make-install.log ; \
    cd ..; \
    rm -fr icu; \
    [ 0 = `ldd /usr/lib64/R/bin/exec/R | grep 'not found' | wc -l` ]

#
# R libraries install.
#
# Note repos=... is necessary for Fedora and RHEL.
#
RUN set -eux; \
    . "${PREFIX}/env.sh"; \
    echo 'install.packages(c("Rcpp", "arrow", "R6", "dplyr", "testthat", "xml2", "lubridate", "zoo"), repos="http://cran.us.r-project.org", quiet=TRUE)' | \
      MAKE="make -j${NCPUS}" R --no-save
