#!/bin/bash
# ==============================================================================
# System Auto-Clean Script for Ubuntu / Debian (APT)
# ==============================================================================

# Ensure the script runs as root
if [ "$EUID" -ne 0 ]; then
  echo "Please run as root"
  exit 1
fi

echo "=== Starting Ubuntu System Cleanup: $(date) ==="

# 1. Clean Package Manager Cache & Metadata
echo "Cleaning APT package cache and removing unused dependencies..."
apt-get update -q               # Refresh package lists quietly
apt-get autoremove -y          # Remove orphaned packages/old kernels no longer needed
apt-get autoclean -y           # Remove obsolete downloaded archive (.deb) files
apt-get clean                  # Clear out the local repository of retrieved package files

# 2. Vacuum systemd Journal Logs (Keep logs only from the last 7 days)
echo "Vacuuming systemd journal logs..."
if command -v journalctl &> /dev/null; then
    journalctl --vacuum-time=7d
fi

# 3. Clean temporary files securely (Older than 7 days)
echo "Cleaning old /tmp files..."
find /tmp -type f -atime +7 -delete

echo "=== Ubuntu System Cleanup Completed: $(date) ==="
