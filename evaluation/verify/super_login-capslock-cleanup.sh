#!/usr/bin/env bash
# Introspection CLEANUP: restore shipped defaults (capslock on, autofocus off). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $c = \Drupal::configFactory()->getEditable("super_login.settings");
  $c->set("super_login.capslock", TRUE);
  $c->set("super_login.autofocus", FALSE);
  $c->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: super_login.capslock=true, autofocus=false"
