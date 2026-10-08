#!/usr/bin/env bash
# Execution CLEANUP: ensure masquerade_log stays enabled (its baseline on this site). Exit 0.
set -uo pipefail
cd /var/www/html
drush en masquerade_log -y >/dev/null 2>&1 || true
echo "cleanup: masquerade_log enabled (baseline)"
