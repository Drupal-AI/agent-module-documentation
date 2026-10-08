#!/usr/bin/env bash
# Introspection CLEANUP: restore shipped default size (16x12). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush config:set languageicons.settings size 16x12 -y >/dev/null 2>&1
echo "cleanup: languageicons.settings size=16x12 (default)"
