#!/usr/bin/env bash
# Execution RESET: set copyprevention_images_search all OFF (shipped baseline), so verify FAILS
# until the agent enables the noimageindex meta tag. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("copyprevention.settings")
    ->set("copyprevention_images_search", ["httpheader" => 0, "pagehead" => 0, "robotstxt" => 0])
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: copyprevention_images_search all off"
