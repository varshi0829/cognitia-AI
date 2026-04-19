#!/bin/bash

# =============================================================================
# Cognitia AI - Development Server Startup Script
# =============================================================================

# Colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

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
    echo -e "${BLUE}  Cognitia AI - Starting Services${NC}"
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

print_info() {
    echo -e "${BLUE}ℹ $1${NC}"
}

check_already_running() {
    local port=$1
    if lsof -i:$port > /dev/null 2>&1; then
        return 0  # running
    else
        return 1  # not running
    fi
}

# =============================================================================
# Main
# =============================================================================

set -e

print_header

# Create directories
print_info "Creating directories..."
mkdir -p "$LOGS_DIR" "$PIDS_DIR"

# Check for Node.js
if ! command -v node &> /dev/null; then
    print_error "Node.js is not installed"
    exit 1
fi

# -----------------------------------------------------------------------------
# Start Backend
# -----------------------------------------------------------------------------
print_info "Starting Backend (port $BACKEND_PORT)..."

if check_already_running $BACKEND_PORT; then
    print_warning "Backend already running on port $BACKEND_PORT"
else
    cd "$PROJECT_ROOT/backend"
    npm run dev > "$LOGS_DIR/backend.log" 2>&1 &
    BACKEND_PID=$!
    echo $BACKEND_PID > "$PIDS_DIR/backend.pid"
    print_success "Backend started (PID: $BACKEND_PID)"
fi

# -----------------------------------------------------------------------------
# Start Frontend
# -----------------------------------------------------------------------------
print_info "Starting Frontend (port $FRONTEND_PORT)..."

if check_already_running $FRONTEND_PORT; then
    print_warning "Frontend already running on port $FRONTEND_PORT"
else
    cd "$PROJECT_ROOT/frontend"
    npm run dev > "$LOGS_DIR/frontend.log" 2>&1 &
    FRONTEND_PID=$!
    echo $FRONTEND_PID > "$PIDS_DIR/frontend.pid"
    print_success "Frontend started (PID: $FRONTEND_PID)"
fi

# -----------------------------------------------------------------------------
# Summary
# -----------------------------------------------------------------------------
echo
echo -e "${BLUE}========================================${NC}"
echo -e "${BLUE}  Services Started Successfully${NC}"
echo -e "${BLUE}========================================${NC}"
echo
echo -e "  ${GREEN}Backend:${NC} http://localhost:$BACKEND_PORT"
echo -e "  ${GREEN}Frontend:${NC} http://localhost:$FRONTEND_PORT"
echo
echo -e "${BLUE}Log files:${NC}"
echo "  - $LOGS_DIR/backend.log"
echo "  - $LOGS_DIR/frontend.log"
echo

# Wait and show status
sleep 3
echo -e "${BLUE}Running processes:${NC}"
if [ -f "$PIDS_DIR/backend.pid" ]; then
    BPID=$(cat "$PIDS_DIR/backend.pid")
    if ps -p $BPID > /dev/null 2>&1; then
        echo -e "  ${GREEN}Backend:${NC} PID $BPID (running)"
    else
        echo -e "  ${YELLOW}Backend:${NC} process not found"
    fi
fi

if [ -f "$PIDS_DIR/frontend.pid" ]; then
    FPID=$(cat "$PIDS_DIR/frontend.pid")
    if ps -p $FPID > /dev/null 2>&1; then
        echo -e "  ${GREEN}Frontend:${NC} PID $FPID (running)"
    else
        echo -e "  ${YELLOW}Frontend:${NC} process not found"
    fi
fi

echo
print_success "All services running!"