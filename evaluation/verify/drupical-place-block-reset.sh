#!/usr/bin/env bash
# Execution RESET: delete every block instance of the events_block plugin so the "place the
# Events Feed block" task starts from empty state.
set -uo pipefail
cd /var/www/html
drush php:eval '
  foreach (\Drupal::entityTypeManager()->getStorage("block")->loadMultiple() as $b) {
    if ($b->getPluginId() === "events_block") { $b->delete(); }
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: all events_block instances removed"
