#!/usr/bin/env bash
# Introspection SETUP: move the login route to a known custom path and mark it noindex, so an
# inspecting agent can read the live login_switch.settings and report the path. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $c = \Drupal::configFactory()->getEditable("login_switch.settings");
  $c->set("login_disabled", TRUE)->set("login_route", "ls-secret-login")->set("login_noindex", TRUE)->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: login_switch.settings login_disabled=true login_route=ls-secret-login login_noindex=true"
