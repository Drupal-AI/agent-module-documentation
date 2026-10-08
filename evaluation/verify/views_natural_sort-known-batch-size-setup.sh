#!/usr/bin/env bash
# Introspection SETUP: set rebuild_items_per_batch to 250 (default 100). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("views_natural_sort.settings")->set("rebuild_items_per_batch", 250)->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: rebuild_items_per_batch=250"
