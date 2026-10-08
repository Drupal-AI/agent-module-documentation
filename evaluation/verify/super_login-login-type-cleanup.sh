#!/usr/bin/env bash
# Introspection CLEANUP: restore Super Login shipped defaults for the keys setup changed.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $c = \Drupal::configFactory()->getEditable("super_login.settings");
  $c->set("super_login.login_type", 0);
  $c->set("super_login.login_title", "Username or e-mail address");
  $c->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: super_login.login_type=0, login_title restored to default"
