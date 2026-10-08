#!/usr/bin/env bash
# Introspection SETUP: disable Webp JPEG fallback generation for the 'thumbnail' image style, so an
# agent can find which style has fallback disabled (wpf.settings styles.disabled). Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("wpf.settings")
    ->set("styles.disabled", ["thumbnail" => "thumbnail"])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: wpf.settings styles.disabled=[thumbnail]"
