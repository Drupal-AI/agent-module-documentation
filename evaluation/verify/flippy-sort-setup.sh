#!/usr/bin/env bash
# Introspection SETUP: configure Article Flippy pager with custom sorting by a field, descending.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("flippy.settings")
    ->set("flippy_article", TRUE)
    ->set("flippy_custom_sorting_article", TRUE)
    ->set("flippy_sort_article", "field_eval_sort")
    ->set("flippy_order_article", "DESC")
    ->save();
' >/dev/null 2>&1
echo "setup: Article flippy custom sort field_eval_sort DESC"
