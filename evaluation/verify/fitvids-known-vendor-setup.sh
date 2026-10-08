#!/usr/bin/env bash
# Introspection SETUP: set fitvids.settings custom_vendors and ignore_selectors to known,
# non-default values so an inspecting agent can read them back. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("fitvids.settings")
    ->set("custom_vendors", "https://vimeo.com")
    ->set("ignore_selectors", ".no-fit")
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: fitvids.settings custom_vendors=https://vimeo.com ignore_selectors=.no-fit"
