#!/usr/bin/env bash
# Execution CLEANUP: restore shipped defaults. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $c = \Drupal::configFactory()->getEditable("restrict_ip.settings");
  $c->set("allow_role_bypass", FALSE);
  $c->set("bypass_action", "provide_link_login_page");
  $c->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: restrict_ip role-bypass settings restored to defaults"
