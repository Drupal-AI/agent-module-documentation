#!/usr/bin/env bash
# Introspection SETUP: put fpa.settings into a KNOWN state — disable ONLY the on-page
# "Page help text" section (disabled_sections = {help}). An inspecting agent reads this
# back from `drush config:get fpa.settings disabled_sections`. Idempotent. Exits 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("fpa.settings")
    ->set("disabled_sections", ["help" => "help"])
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: fpa.settings disabled_sections = {help}"
