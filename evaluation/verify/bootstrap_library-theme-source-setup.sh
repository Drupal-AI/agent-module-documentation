#!/usr/bin/env bash
# Introspection SETUP: restrict bootstrap_library to a single theme (olivero) and switch the
# local library variant to the non-minified/source build, so the agent must read the live
# bootstrap_library.settings to answer. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("bootstrap_library.settings")
    ->set("theme.visibility", 1)
    ->set("theme.themes", ["olivero" => "olivero"])
    ->set("minimized.options", 0)
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: bootstrap_library theme.visibility=1 themes=[olivero] minimized.options=0 (source)"
