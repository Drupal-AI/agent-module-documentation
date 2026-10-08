#!/usr/bin/env bash
# Execution RESET: force the Article 'Save and add another' button OFF so verify FAILS until the
# agent enables it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $c = \Drupal::configFactory()->getEditable("addanother.settings");
  $c->set("default_button", TRUE)->set("button.article", FALSE)->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: addanother.settings button.article=false"
