#!/usr/bin/env bash
# Introspection SETUP: give Article an explicit button override (disabled) that differs from
# the site default_button (enabled), so an inspecting agent can read it back. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $c = \Drupal::configFactory()->getEditable("addanother.settings");
  $c->set("default_button", TRUE)->set("button.article", FALSE)->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: addanother.settings button.article=false (default_button=true)"
