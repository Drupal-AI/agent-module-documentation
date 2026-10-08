#!/usr/bin/env bash
# Execution RESET: force Super Login back to username-or-email (login_type=0) with the caps-lock
# warning ON, so verify FAILS until the agent makes it email-only with caps lock off. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $c = \Drupal::configFactory()->getEditable("super_login.settings");
  $c->set("super_login.login_type", 0);
  $c->set("super_login.capslock", TRUE);
  $c->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: super_login.login_type=0, capslock=true"
