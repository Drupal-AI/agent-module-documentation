#!/usr/bin/env bash
# Introspection SETUP: set a known disclaimer title so the agent can read it back. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("google_translator.settings")
    ->set("google_translator_disclaimer_title", "GT Eval Notice Zephyr")
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: google_translator disclaimer_title=GT Eval Notice Zephyr"
