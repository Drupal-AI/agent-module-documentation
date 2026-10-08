#!/usr/bin/env bash
# Execution CLEANUP: delete the ebe_task entity browser and its enhancer config object. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  if ($b = \Drupal::entityTypeManager()->getStorage("entity_browser")->load("ebe_task")) { $b->delete(); }
  \Drupal::configFactory()->getEditable("entity_browser_enhanced.widgets.ebe_task")->delete();
' >/dev/null 2>&1
echo "cleanup: ebe_task browser and entity_browser_enhanced.widgets.ebe_task removed"
