#!/usr/bin/env bash
# Introspection SETUP: enable noindex on ONLY the password (reset) route so an agent inspecting
# live login_switch.settings can identify which of the three auth routes sends noindex. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $c = \Drupal::configFactory()->getEditable("login_switch.settings");
  $c->set("login_noindex", FALSE)->set("register_noindex", FALSE)->set("password_noindex", TRUE)->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: only password_noindex=true"
