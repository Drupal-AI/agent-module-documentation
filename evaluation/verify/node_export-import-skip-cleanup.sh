#!/usr/bin/env bash
# Introspection CLEANUP: restore shipped default ('replace'). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush cset node_export.settings node_export_import replace -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: node_export.settings node_export_import=replace"
