#!/usr/bin/env bash
# Execution CLEANUP: restore login_switch shipped defaults. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $c = \Drupal::configFactory()->getEditable("login_switch.settings");
  foreach (["login","register","password"] as $k) {
    $c->set($k."_disabled", FALSE)->set($k."_route", "")->set($k."_noindex", FALSE);
  }
  $c->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: login_switch.settings restored to defaults"
