#!/usr/bin/env bash
# Introspection SETUP: ensure entity_reference_exposed_filters is enabled so its views filter is
# registered in views data. Idempotent.
set -uo pipefail
cd /var/www/html
drush pm:list --status=enabled --format=list 2>/dev/null | grep -qx entity_reference_exposed_filters || drush en entity_reference_exposed_filters -y >/dev/null 2>&1
echo "setup: entity_reference_exposed_filters enabled"
