#!/usr/bin/env bash
# Introspection SETUP: rename total_items label to 'count' and disable the current_page field,
# so an inspecting agent can read the live labels/flags. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("pager_serializer.settings")
    ->set("total_items_label","count")->set("current_page_enabled",FALSE)->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: pager_serializer total_items_label=count, current_page_enabled=false"
