FROM buildkite/agent:3-ubuntu

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
