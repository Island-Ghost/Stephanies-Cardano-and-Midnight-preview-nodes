#!/bin/bash

# Helper script to query Stephanie's Cardano Preview Node
set -e

export CARDANO_NODE_SOCKET_PATH="/opt/cardano/data/node.socket"
TESTNET_MAGIC=2

echo "=== Stephanie's Preview Node Query Tool ==="
echo

# Function to check if node is running
check_node() {
    if [ ! -S "$CARDANO_NODE_SOCKET_PATH" ]; then
        echo "❌ Node socket not found. Is the node running?"
        exit 1
    fi
    echo "✅ Node socket found at: $CARDANO_NODE_SOCKET_PATH"
}

# Function to query tip
query_tip() {
    echo "📊 Querying blockchain tip..."
    cardano-cli query tip --testnet-magic $TESTNET_MAGIC
}

# Function to query protocol parameters
query_protocol() {
    echo "⚙️  Querying protocol parameters..."
    cardano-cli query protocol-parameters --testnet-magic $TESTNET_MAGIC
}

# Function to show node version
show_version() {
    echo "🔧 Cardano CLI Version:"
    cardano-cli --version
    echo
    echo "🔧 Cardano Node Version:"
    cardano-node --version
}

# Main execution
case "${1:-tip}" in
    "tip")
        check_node
        query_tip
        ;;
    "protocol")
        check_node
        query_protocol
        ;;
    "version")
        show_version
        ;;
    "status")
        check_node
        echo "📈 Node Status:"
        query_tip
        ;;
    *)
        echo "Usage: $0 [tip|protocol|version|status]"
        echo "  tip      - Show current blockchain tip (default)"
        echo "  protocol - Show protocol parameters"
        echo "  version  - Show software versions"
        echo "  status   - Show node status"
        exit 1
        ;;
esac
