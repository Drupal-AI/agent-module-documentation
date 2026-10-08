#!/usr/bin/env bash
# Introspection SETUP: set a known placeholder and animation theme in better_search.settings so
# an inspecting agent can read them back. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("better_search.settings")
    ->set("placeholder_text", "Find content here")
    ->set("theme", 2)->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: better_search.settings placeholder_text='Find content here', theme=2"
