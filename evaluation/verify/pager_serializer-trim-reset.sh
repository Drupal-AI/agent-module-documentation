#!/usr/bin/env bash
# Execution RESET: restore pager_serializer defaults so verify FAILS until the agent disables
# total_pages and renames items_per_page. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("pager_serializer.settings")->set("rows_label","rows")->set("pager_label","pager")->set("pager_object_enabled",TRUE)->set("current_page_enabled",TRUE)->set("current_page_label","current_page")->set("total_items_enabled",TRUE)->set("total_items_label","total_items")->set("total_pages_enabled",TRUE)->set("total_pages_label","total_pages")->set("items_per_page_enabled",TRUE)->set("items_per_page_label","items_per_page")->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: pager_serializer defaults"
