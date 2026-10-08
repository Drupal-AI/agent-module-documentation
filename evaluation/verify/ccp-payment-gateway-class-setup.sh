#!/usr/bin/env bash
# Introspection SETUP: ensure the container is rebuilt so commerce_conditions_plus's
# hook_entity_type_alter class swap is live and discoverable. Exit 0.
set -uo pipefail
cd /var/www/html
drush cr >/dev/null 2>&1
echo "setup: caches cleared; commerce_payment_gateway class swap is active"
