#!/usr/bin/env bash
# Execution RESET: restore login_switch shipped defaults so verify FAILS until the agent moves
# the login route. Idempotent. Exit 0.
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
echo "reset: login_switch.settings all defaults (login route untouched)"
