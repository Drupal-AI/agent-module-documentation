#!/usr/bin/env bash
# Introspection SETUP: enable typed_entity_example so its repositories register. Idempotent.
set -uo pipefail
cd /var/www/html
drush en typed_entity_example -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: typed_entity_example enabled"
