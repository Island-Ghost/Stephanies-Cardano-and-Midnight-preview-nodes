# Cardano Preview Node Dockerfile
FROM ubuntu:22.04

LABEL maintainer="Stephanie's Preview Node"
LABEL name="cardano-preview-node"
LABEL version="8.7.3"

# Set the SHELL to bash with pipefail option
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# Prevent dialog during apt install
ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies
RUN apt-get update && apt-get install -y \
    curl \
    wget \
    jq \
    bc \
    tcptraceroute \
    net-tools \
    procps \
    unzip \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Set Cardano version
ENV CARDANO_NODE_VERSION=8.7.3

# Download and install Cardano node binaries
RUN mkdir -p /opt/cardano/bin && \
    cd /tmp && \
    wget https://github.com/IntersectMBO/cardano-node/releases/download/${CARDANO_NODE_VERSION}/cardano-node-${CARDANO_NODE_VERSION}-linux.tar.gz && \
    tar -xzf cardano-node-${CARDANO_NODE_VERSION}-linux.tar.gz && \
    mv cardano-node cardano-cli /opt/cardano/bin/ && \
    chmod +x /opt/cardano/bin/* && \
    rm -rf /tmp/*

# Add Cardano binaries to PATH
ENV PATH="/opt/cardano/bin:${PATH}"

# Create cardano user
RUN useradd -m -s /bin/bash cardano

# Create directories
RUN mkdir -p /opt/cardano/config && \
    mkdir -p /opt/cardano/data && \
    mkdir -p /opt/cardano/logs && \
    mkdir -p /opt/cardano/scripts && \
    chown -R cardano:cardano /opt/cardano

# Switch to cardano user
USER cardano
WORKDIR /opt/cardano

# Copy configuration files
COPY --chown=cardano:cardano config/ /opt/cardano/config/
COPY --chown=cardano:cardano scripts/ /opt/cardano/scripts/

# Expose Cardano node port
EXPOSE 3001 12798

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=120s --retries=3 \
    CMD curl -f http://localhost:12798/metrics || exit 1

# Set entrypoint
ENTRYPOINT ["/opt/cardano/scripts/start-node.sh"]
