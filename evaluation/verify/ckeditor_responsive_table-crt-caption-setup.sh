#!/usr/bin/env bash
# Introspection SETUP: set a known caption_side on ckeditor_responsive_table.settings.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("ckeditor_responsive_table.settings")
    ->set("caption_side","bottom")->set("table_selector",".crt-known table")->save();
' >/dev/null 2>&1
echo "setup: ckeditor_responsive_table.settings caption_side=bottom, table_selector='.crt-known table'"
