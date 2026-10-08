#!/usr/bin/env bash
# Execution RESET: make sure the account pl_task_user exists and holds NO persistent login
# tokens, so the verify below fails on empty state. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\user\Entity\User;
  $u = user_load_by_name("pl_task_user");
  if (!$u) {
    $u = User::create(["name" => "pl_task_user", "mail" => "pl_task_user@example.com", "status" => 1]);
    $u->save();
  }
  \Drupal::service("persistent_login.token_manager")->clearUsersTokens($u);
  \Drupal::configFactory()->getEditable("persistent_login.settings")->set("lifetime", 30)->save();
' >/dev/null 2>&1
echo "reset: user pl_task_user exists with zero persistent login tokens"
