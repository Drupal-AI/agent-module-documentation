#!/usr/bin/env bash
# Introspection SETUP: set a known contact email and page-check mode in restrict_ip.settings so
# an agent can read them back. Does NOT enable the restriction. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $c = \Drupal::configFactory()->getEditable("restrict_ip.settings");
  $c->set("mail_address", "ripblocked@example.com");
  $c->set("white_black_list", 2);
  $c->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: restrict_ip.settings mail_address=ripblocked@example.com white_black_list=2 (enable untouched)"
