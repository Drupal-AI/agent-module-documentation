#!/usr/bin/env bash
# Introspection SETUP: turn the Super Login caps-lock warning OFF and username autofocus ON,
# so an inspecting agent can read these live toggles. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $c = \Drupal::configFactory()->getEditable("super_login.settings");
  $c->set("super_login.capslock", FALSE);
  $c->set("super_login.autofocus", TRUE);
  $c->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: super_login.capslock=false, autofocus=true"
