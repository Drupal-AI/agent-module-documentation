#!/usr/bin/env bash
# Introspection SETUP: set a known login_message and login_destination in require_login.settings.
set -uo pipefail
cd /var/www/html
drush php:eval '$c = \Drupal::configFactory()->getEditable("require_login.settings"); $c->set("login_message","Please sign in to view members content")->set("login_destination","/dashboard")->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: login_message and login_destination(/dashboard) set"
