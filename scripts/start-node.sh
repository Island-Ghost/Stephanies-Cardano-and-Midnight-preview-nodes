#!/bin/bash

# Stephanie's Preview Node Startup Script
set -e

echo "Starting Stephanie's Cardano Preview Node..."

# Set environment variables
export CARDANO_NODE_SOCKET_PATH="/opt/cardano/data/node.socket"
export CARDANO_NETWORK="preview"

# Create data directory if it doesn't exist
mkdir -p /opt/cardano/data
mkdir -p /opt/cardano/logs

# Function to cleanup on exit
cleanup() {
    echo "Shutting down Cardano node..."
    kill -TERM $NODE_PID 2>/dev/null || true
    wait $NODE_PID 2>/dev/null || true
    echo "Cardano node stopped."
}

# Set trap for cleanup
trap cleanup SIGTERM SIGINT

# Start the Cardano node (passive node - no block production)
echo "Launching cardano-node with preview testnet configuration..."
cardano-node run \
    --topology /opt/cardano/config/topology.json \
    --database-path /opt/cardano/data \
    --socket-path /opt/cardano/data/node.socket \
    --host-addr 0.0.0.0 \
    --port 3001 \
    --config /opt/cardano/config/config.json &

NODE_PID=$!

echo "Cardano node started with PID: $NODE_PID"
echo "Node socket: $CARDANO_NODE_SOCKET_PATH"
echo "Network: $CARDANO_NETWORK (testnet-magic: 2)"
echo "Prometheus metrics available at: http://localhost:12798/metrics"

# Wait for the node process
wait $NODE_PID
