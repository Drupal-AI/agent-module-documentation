#!/usr/bin/env bash
# Introspection SETUP: set a known display mode + languages on google_translator.settings so an
# inspecting agent can read them back. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("google_translator.settings")
    ->set("google_translator_active_languages_display_mode", "VERTICAL")
    ->set("google_translator_active_languages", ["fr", "de"])
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: google_translator display_mode=VERTICAL languages=[fr,de]"
