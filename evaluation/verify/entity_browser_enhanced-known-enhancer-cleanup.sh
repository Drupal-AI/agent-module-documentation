#!/usr/bin/env bash
# Introspection CLEANUP: delete the ebe_demo entity browser and its enhancer config object.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  if ($b = \Drupal::entityTypeManager()->getStorage("entity_browser")->load("ebe_demo")) { $b->delete(); }
  \Drupal::configFactory()->getEditable("entity_browser_enhanced.widgets.ebe_demo")->delete();
' >/dev/null 2>&1
echo "cleanup: ebe_demo browser and entity_browser_enhanced.widgets.ebe_demo removed"
