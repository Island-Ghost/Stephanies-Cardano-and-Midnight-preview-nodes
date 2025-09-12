# Stephanie's Midnight Validator Node - Preview Mode

A complete Midnight network validator node setup integrated with Cardano Preview testnet using Docker.

## Overview

This project sets up a full Midnight validator infrastructure including:
- Cardano Preview testnet node
- Midnight validator node (testnet-02)
- PostgreSQL database with Cardano DB Sync
- Cardano Ogmios WebSocket API
- Midnight Proof Server
- Complete monitoring and management tools

## Quick Start

1. Navigate to the midnight-node-docker directory:
   ```bash
   cd midnight-node-docker
   ```

2. Start all services:
   ```bash
   docker-compose up -d
   ```

3. Monitor services:
   ```bash
   ./monitor-logs.sh
   ```

## Services & Ports

- **Cardano Node**: Port 3001 (Preview testnet)
- **PostgreSQL**: Port 5432 (cexplorer database)
- **Cardano Ogmios**: Port 1337 (WebSocket API)
- **Midnight Node**: Ports 9944 (RPC), 9615 (metrics), 30333 (P2P)
- **Proof Server**: Port 6300

## Validator Configuration

The setup includes validator keys and configuration for Midnight testnet-02 participation. See `midnight-node-docker/validator-info.txt` for complete validator details.

## Monitoring

Use the provided monitoring script to view real-time logs and health status of all services.
