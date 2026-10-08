#!/usr/bin/env bash
# Execution RESET: force role-bypass OFF and bypass_action to the shipped default so verify
# FAILS until the agent configures it. Does NOT enable the restriction. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $c = \Drupal::configFactory()->getEditable("restrict_ip.settings");
  $c->set("allow_role_bypass", FALSE);
  $c->set("bypass_action", "provide_link_login_page");
  $c->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: allow_role_bypass=FALSE bypass_action=provide_link_login_page"
