#!/bin/bash
# ==============================================================================
# Dedicated YUM System Auto-Clean Script
# ==============================================================================

if [ "$EUID" -ne 0 ]; then
  echo "Please run as root"
  exit 1
fi

echo "=== Starting YUM System Cleanup: $(date) ==="

# 1. Purge YUM Cache and Metadata
echo "Purging YUM package caches..."
yum clean all

# 2. Remove orphaned dependencies
echo "Removing orphaned packages..."
yum autoremove -y

# 3. Vacuum systemd Journal Logs (Keep last 7 days)
echo "Trimming systemd logs..."
if command -v journalctl &> /dev/null; then
    journalctl --vacuum-time=7d
fi

# 4. Clean old /tmp files (Older than 7 days)
echo "Purging old temporary files..."
find /tmp -type f -atime +7 -delete

echo "=== YUM System Cleanup Completed: $(date) ==="
