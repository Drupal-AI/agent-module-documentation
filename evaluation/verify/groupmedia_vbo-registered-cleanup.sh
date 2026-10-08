#!/usr/bin/env bash
# Introspection CLEANUP: leave groupmedia_vbo enabled (documented baseline). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush en groupmedia_vbo -y >/dev/null 2>&1
echo "cleanup: groupmedia_vbo left enabled (baseline)"
