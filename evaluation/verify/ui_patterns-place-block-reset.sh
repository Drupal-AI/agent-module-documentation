#!/usr/bin/env bash
# Clear state: delete every block whose plugin is a UI Patterns component block, so the
# task starts from empty. After this, verify must FAIL until the agent places one.
set -uo pipefail
cd /var/www/html
drush php:eval '
  foreach (\Drupal::entityTypeManager()->getStorage("block")->loadMultiple() as $b) {
    if (strpos((string) $b->getPluginId(), "ui_patterns:") === 0) { $b->delete(); }
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: all ui_patterns component blocks removed"
