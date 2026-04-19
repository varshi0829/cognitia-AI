#!/bin/bash

# =============================================================================
# Cognitia AI - Restart All Services Script
# =============================================================================

# Colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m'

# =============================================================================
# Main
# =============================================================================

echo -e "${BLUE}========================================${NC}"
echo -e "${BLUE}  Cognitia AI - Restarting Services${NC}"
echo -e "${BLUE}========================================${NC}"
echo

# Stop all services
echo "Stopping services..."
bash "$(dirname "${BASH_SOURCE[0]}")/stop_all.sh"

echo

# Start all services
echo "Starting services..."
bash "$(dirname "${BASH_SOURCE[0]}")/run_all.sh"