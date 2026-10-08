#!/usr/bin/env bash
# Execution RESET: restore shipped legal.settings baseline (accept_every_login FALSE, no
# exempt roles) so verify FAILS until the agent changes them. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $c = \Drupal::configFactory()->getEditable("legal.settings");
  $c->set("accept_every_login", FALSE);
  $c->set("except_roles", []);
  $c->save();
' >/dev/null 2>&1
echo "reset: legal.settings accept_every_login=FALSE, except_roles=[]"
