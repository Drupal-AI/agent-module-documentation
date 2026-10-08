#!/usr/bin/env bash
# MEDIUM introspection SETUP: ensure entity_hierarchy_breadcrumb is enabled so an agent can
# inspect its breadcrumb_builder service. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush en entity_hierarchy_breadcrumb -y >/dev/null 2>&1
echo "setup: entity_hierarchy_breadcrumb enabled"
