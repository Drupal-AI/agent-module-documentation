#!/usr/bin/env bash
# Introspection SETUP: enable typed_entity_ui so its explorer route registers. Idempotent.
set -uo pipefail
cd /var/www/html
drush en typed_entity_ui -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: typed_entity_ui enabled; explorer route registered"
