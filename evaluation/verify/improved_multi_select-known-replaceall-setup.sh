#!/usr/bin/env bash
# Introspection SETUP: enable replace-all + a known Add button label. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $c = \Drupal::configFactory()->getEditable("improved_multi_select.settings");
  $c->set("isall", TRUE)->set("buttontext_add", "ADDIMS")->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: improved_multi_select.settings isall=true buttontext_add=ADDIMS"
