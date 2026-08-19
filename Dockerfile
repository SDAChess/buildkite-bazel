FROM docker.io/buildkite/hosted-agent-base:ubuntu-v1.0.1@sha256:f1378abd34fccb2b7b661aaf3b06394509a4f7b5bb8c2f8ad431e7eaa1cabc9c

LABEL org.opencontainers.image.source=https://github.com/SDAChess/buildkite-bazel

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        build-essential \
        python3 \
    && rm -rf /var/lib/apt/lists/*

ARG TARGETARCH
ARG BAZEL_VERSION=9.1.1

RUN case "${TARGETARCH}" in \
        amd64) bazel_arch="x86_64" ;; \
        arm64) bazel_arch="arm64" ;; \
        *) exit 1 ;; \
    esac \
    && curl -fsSLo /usr/local/bin/bazel \
        "https://releases.bazel.build/${BAZEL_VERSION}/release/bazel-${BAZEL_VERSION}-linux-${bazel_arch}" \
    && chmod 0755 /usr/local/bin/bazel

RUN bazel --batch help >/dev/null
