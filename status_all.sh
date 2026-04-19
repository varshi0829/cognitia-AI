#!/bin/bash

# =============================================================================
# Cognitia AI - Status Check Script
# =============================================================================

# Colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m'

# Directories
PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LOGS_DIR="$PROJECT_ROOT/logs"
PIDS_DIR="$PROJECT_ROOT/.pids"

# Ports
BACKEND_PORT=5000
FRONTEND_PORT=5173

# =============================================================================
# Functions
# =============================================================================

print_header() {
    echo -e "${BLUE}========================================${NC}"
    echo -e "${BLUE}  Cognitia AI - Service Status${NC}"
    echo -e "${BLUE}========================================${NC}"
    echo
}

check_port() {
    local port=$1
    if lsof -i:$port > /dev/null 2>&1; then
        return 0
    else
        return 1
    fi
}

get_pid_from_port() {
    local port=$1
    lsof -ti:$port 2>/dev/null
}

# =============================================================================
# Main
# =============================================================================

print_header

# -----------------------------------------------------------------------------
# Backend Status
# -----------------------------------------------------------------------------
echo -e "${BLUE}Backend (port $BACKEND_PORT):${NC}"

if [ -f "$PIDS_DIR/backend.pid" ]; then
    BPID=$(cat "$PIDS_DIR/backend.pid")
    
    if ps -p $BPID > /dev/null 2>&1; then
        echo -e "  ${GREEN}● Running${NC} (PID: $BPID)"
    else
        echo -e "  ${YELLOW}○ Stopped${NC} (stale PID: $BPID)"
    fi
else
    if check_port $BACKEND_PORT; then
        PID=$(get_pid_from_port $BACKEND_PORT)
        echo -e "  ${GREEN}● Running${NC} (PID: $PID, found via port)"
    else
        echo -e "  ${RED}○ Not running${NC}"
    fi
fi

echo "  Log: $LOGS_DIR/backend.log"

# -----------------------------------------------------------------------------
# Frontend Status
# -----------------------------------------------------------------------------
echo
echo -e "${BLUE}Frontend (port $FRONTEND_PORT):${NC}"

if [ -f "$PIDS_DIR/frontend.pid" ]; then
    FPID=$(cat "$PIDS_DIR/frontend.pid")
    
    if ps -p $FPID > /dev/null 2>&1; then
        echo -e "  ${GREEN}● Running${NC} (PID: $FPID)"
    else
        echo -e "  ${YELLOW}○ Stopped${NC} (stale PID: $FPID)"
    fi
else
    if check_port $FRONTEND_PORT; then
        PID=$(get_pid_from_port $FRONTEND_PORT)
        echo -e "  ${GREEN}● Running${NC} (PID: $PID, found via port)"
    else
        echo -e "  ${RED}○ Not running${NC}"
    fi
fi

echo "  Log: $LOGS_DIR/frontend.log"

# -----------------------------------------------------------------------------
# Quick Links
# -----------------------------------------------------------------------------
echo
echo -e "${BLUE}Quick Links:${NC}"
echo "  Backend: http://localhost:$BACKEND_PORT"
echo "  Frontend: http://localhost:$FRONTEND_PORT"
echo
echo "  Status: bash status_all.sh"
echo "  Stop: bash stop_all.sh"
echo "  Restart: bash restart_all.sh"