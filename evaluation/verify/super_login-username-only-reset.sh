#!/usr/bin/env bash
# Execution RESET: force login_type=0 and login_title back to the shipped default, so verify
# FAILS until the agent sets username-only + the 'Staff sign in' title. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $c = \Drupal::configFactory()->getEditable("super_login.settings");
  $c->set("super_login.login_type", 0);
  $c->set("super_login.login_title", "Username or e-mail address");
  $c->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: super_login.login_type=0, login_title default"
