#!/usr/bin/env bash
# Execution CLEANUP: restore the shipped default (status=false, tracks=globally_enabled). Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $c = \Drupal::configFactory()->getEditable("email_tfa.settings");
  $c->set("status", FALSE);
  $c->set("tracks", "globally_enabled");
  $c->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: email_tfa.settings status restored to FALSE"
