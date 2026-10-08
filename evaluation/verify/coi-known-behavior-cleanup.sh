#!/usr/bin/env bash
# Introspection CLEANUP: restore coi.settings override_behavior to shipped default 'disable'.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush config:set coi.settings override_behavior disable -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: coi.settings override_behavior restored to disable"
