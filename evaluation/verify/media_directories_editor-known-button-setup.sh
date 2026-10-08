#!/usr/bin/env bash
# Introspection SETUP: constrain the module's own embed button config to a known state — only
# the image bundle allowed — so the agent must read the live embed.button.media_directories
# config to answer. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html

drush php:eval '
  $config = \Drupal::configFactory()->getEditable("embed.button.media_directories");
  if (!$config->isNew()) {
    $config->set("type_settings.bundles", ["image"])->save();
  }
' >/dev/null 2>&1

state=$(drush php:eval 'print json_encode(\Drupal::config("embed.button.media_directories")->get("type_settings.bundles"));' 2>/dev/null)
echo "setup: embed.button.media_directories type_settings.bundles = ${state}"
