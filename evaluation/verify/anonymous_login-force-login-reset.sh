#!/usr/bin/env bash
# Execution RESET: restore anonymous_login shipped default {login_path:/user/login} (no paths),
# so verify FAILS until the agent adds an include for /portal. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("anonymous_login.settings")->setData(["login_path"=>"/user/login"])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: anonymous_login.settings default (no paths)"
