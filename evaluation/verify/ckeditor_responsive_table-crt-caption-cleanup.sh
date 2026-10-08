#!/usr/bin/env bash
# Introspection CLEANUP: clear the live keys, restoring shipped baseline (only default_* keys).
set -uo pipefail
cd /var/www/html
drush php:eval '
  $c = \Drupal::configFactory()->getEditable("ckeditor_responsive_table.settings");
  $c->clear("caption_side")->clear("table_selector")->save();
' >/dev/null 2>&1
echo "cleanup: caption_side/table_selector cleared"
