#!/usr/bin/env bash
# Introspection CLEANUP: remove the whole add_to_head.settings config written by the matching
# setup, restoring baseline (no config object, no profiles). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush config:delete add_to_head.settings >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: add_to_head.settings deleted"
