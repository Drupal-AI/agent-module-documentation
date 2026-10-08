#!/usr/bin/env bash
# Execution CLEANUP: restore anonymous_login shipped default. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("anonymous_login.settings")->setData(["login_path"=>"/user/login"])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: anonymous_login.settings restored to default"
