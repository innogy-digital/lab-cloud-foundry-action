FROM alpine:3.11.3

LABEL "name"="Cloud Foundry CLI Action"
LABEL "maintainer"=""
LABEL "version"="v1.0"

LABEL "com.github.actions.name"="GitHub Action to execute pcf cli with ssh proxy"
LABEL "com.github.actions.description"="Wraps the Cloud foundry CLI to enable CF commands over a ssh proxy."
LABEL "com.github.actions.icon"="cloud"
LABEL "com.github.actions.color"="green"

# Install uuidgen
RUN apk add --no-cache ca-certificates curl bash jq util-linux openssh coreutils

# Install Cloud Foundry cli
RUN mkdir -p /usr/local/bin && \
    curl -L "https://packages.cloudfoundry.org/stable?release=linux64-binary&source=github" | tar -zx -C /usr/local/bin && \
    cf --version

COPY cf-proxy.sh /cf-proxy.sh
COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]