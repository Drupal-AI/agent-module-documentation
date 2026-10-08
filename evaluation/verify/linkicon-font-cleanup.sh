#!/usr/bin/env bash
# Introspection CLEANUP: restore baseline (no icon-font path). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush cset linkicon.settings font '' -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: linkicon.settings font reset to empty"
