#!/usr/bin/env bash
# Execution CLEANUP: restore copyprevention_images_search to all off (baseline). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("copyprevention.settings")
    ->set("copyprevention_images_search", ["httpheader" => 0, "pagehead" => 0, "robotstxt" => 0])
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: copyprevention_images_search all off"
