#!/usr/bin/env bash
# Execution RESET: restore shipped default (no paths) so verify FAILS until the agent adds both
# an include for /reports and a ~-exclude for /reports/public. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("anonymous_login.settings")->setData(["login_path"=>"/user/login"])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: anonymous_login.settings default (no paths)"
