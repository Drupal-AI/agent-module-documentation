#!/usr/bin/env bash
# Execution RESET: (re)create user dbee_upd with an initial email dbee_old@example.com so the
# agent can change it. Ensures the target email dbee_upd_new@example.com is not yet set (verify
# FAILS until the agent updates and dbee re-encrypts it). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\user\Entity\User;
  if ($u = user_load_by_name("dbee_upd")) { $u->delete(); }
  User::create(["name"=>"dbee_upd","mail"=>"dbee_old@example.com","status"=>1])->save();
' >/dev/null 2>&1
echo "reset: user dbee_upd present with email dbee_old@example.com"
