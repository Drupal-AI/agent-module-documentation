#!/usr/bin/env bash
# Introspection SETUP: set a known Google API key in gtext.settings so an inspecting agent can
# read it back. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("gtext.settings")
    ->set("google_api_key", "AIzaSyGTEXT-known-eval-key-123")->save();
' >/dev/null 2>&1
echo "setup: gtext.settings google_api_key set to known eval key"
