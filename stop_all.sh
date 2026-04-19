#!/bin/bash

# =============================================================================
# Cognitia AI - Stop All Services Script
# =============================================================================

# Colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m'

# Directories
PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PIDS_DIR="$PROJECT_ROOT/.pids"

# =============================================================================
# Functions
# =============================================================================

print_header() {
    echo -e "${BLUE}========================================${NC}"
    echo -e "${BLUE}  Cognitia AI - Stopping Services${NC}"
    echo -e "${BLUE}========================================${NC}"
    echo
}

print_success() {
    echo -e "${GREEN}✓ $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}⚠ $1${NC}"
}

print_error() {
    echo -e "${RED}✗ $1${NC}"
}

stop_process() {
    local name=$1
    local pid_file=$2
    
    if [ -f "$pid_file" ]; then
        local pid=$(cat "$pid_file")
        
        if ps -p $pid > /dev/null 2>&1; then
            kill $pid 2>/dev/null || true
            sleep 1
            
            if ps -p $pid > /dev/null 2>&1; then
                kill -9 $pid 2>/dev/null || true
            fi
            
            print_success "$name stopped (PID: $pid)"
        else
            print_warning "$name was not running (stale PID: $pid)"
        fi
        
        rm -f "$pid_file"
    else
        print_warning "$name PID file not found"
    fi
}

# =============================================================================
# Main
# =============================================================================

set -e

print_header

echo -e "${YELLOW}Stopping all services...${NC}"
echo

# Stop Frontend first (since it depends on backend)
stop_process "Frontend" "$PIDS_DIR/frontend.pid"

# Stop Backend
stop_process "Backend" "$PIDS_DIR/backend.pid"

echo
print_success "All services stopped!"