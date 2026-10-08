#!/usr/bin/env bash
# Introspection CLEANUP: restore shipped defaults for the keys the setup changed. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $c = \Drupal::configFactory()->getEditable("restrict_ip.settings");
  $c->set("mail_address", "");
  $c->set("white_black_list", 0);
  $c->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: restrict_ip.settings mail_address+white_black_list restored to defaults"
