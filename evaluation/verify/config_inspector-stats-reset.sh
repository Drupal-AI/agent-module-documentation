#!/usr/bin/env bash
# Execution RESET/CLEANUP: remove the statistics artifact so verify FAILS on empty state. Exit 0.
set -uo pipefail
rm -f /var/www/html/config_inspector_stats.json
echo "reset: removed /var/www/html/config_inspector_stats.json"
