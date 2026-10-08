#!/usr/bin/env bash
# Introspection CLEANUP: restore fitvids.settings custom_vendors and ignore_selectors to the
# shipped defaults (https://youtu.be and empty). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("fitvids.settings")
    ->set("custom_vendors", "https://youtu.be")
    ->set("ignore_selectors", "")
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: fitvids.settings custom_vendors/ignore_selectors restored to defaults"
