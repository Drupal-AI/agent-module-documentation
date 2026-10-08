#!/usr/bin/env bash
# Introspection SETUP: insert a login_history row for uid 1 with a distinctive IP so the
# agent can find it by querying the live login_history table. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::database()->delete("login_history")->condition("hostname", "198.51.100.42")->execute();
  \Drupal::database()->insert("login_history")->fields([
    "uid" => 1, "login" => \Drupal::time()->getRequestTime(),
    "hostname" => "198.51.100.42", "one_time" => 0, "user_agent" => "LoginHistoryEval/1.0",
  ])->execute();
' >/dev/null 2>&1
echo "setup: login_history row for uid=1 hostname=198.51.100.42"
