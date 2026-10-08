#!/usr/bin/env bash
# Execution RESET for "restrict the Media Directories embed button to specific bundles".
# Clears type_settings.bundles on embed.button.media_directories so verify FAILS on empty
# state. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html

drush php:eval '
  $config = \Drupal::configFactory()->getEditable("embed.button.media_directories");
  if (!$config->isNew()) { $config->set("type_settings.bundles", [])->save(); }
' >/dev/null 2>&1

echo "reset: embed.button.media_directories type_settings.bundles cleared"
