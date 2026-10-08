#!/usr/bin/env bash
# MEDIUM introspection cleanup: remove the layout_builder_blocks.styles config so the site
# returns to its baseline (no restrictions, no config object).
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("layout_builder_blocks.styles")->delete();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: layout_builder_blocks.styles config removed"
