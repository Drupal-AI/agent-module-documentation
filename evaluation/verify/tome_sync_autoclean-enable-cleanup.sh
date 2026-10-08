#!/usr/bin/env bash
# Execution CLEANUP: re-enable tome_sync_autoclean to restore the site baseline (all Tome
# sub-modules enabled). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush en tome_sync_autoclean -y >/dev/null 2>&1
echo "cleanup: tome_sync_autoclean enabled (baseline restored)"
