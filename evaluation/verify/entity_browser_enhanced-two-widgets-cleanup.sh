#!/usr/bin/env bash
# Introspection CLEANUP: delete the ebe_two entity browser and its enhancer config object. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  if ($b = \Drupal::entityTypeManager()->getStorage("entity_browser")->load("ebe_two")) { $b->delete(); }
  \Drupal::configFactory()->getEditable("entity_browser_enhanced.widgets.ebe_two")->delete();
' >/dev/null 2>&1
echo "cleanup: ebe_two browser and entity_browser_enhanced.widgets.ebe_two removed"
