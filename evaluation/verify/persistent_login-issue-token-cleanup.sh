#!/usr/bin/env bash
# Execution CLEANUP: clear the tokens and delete the account created by the reset.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  if ($u = user_load_by_name("pl_task_user")) {
    \Drupal::service("persistent_login.token_manager")->clearUsersTokens($u);
    $u->delete();
  }
' >/dev/null 2>&1
echo "cleanup: user pl_task_user and its persistent login tokens removed"
