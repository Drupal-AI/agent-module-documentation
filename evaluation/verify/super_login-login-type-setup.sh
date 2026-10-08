#!/usr/bin/env bash
# Introspection SETUP: configure Super Login for email-only login (login_type=2) and a custom
# login title, so an inspecting agent can read the live config. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $c = \Drupal::configFactory()->getEditable("super_login.settings");
  $c->set("super_login.login_type", 2);
  $c->set("super_login.login_title", "Sign in with your email");
  $c->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: super_login.login_type=2 (email only), login_title customised"
