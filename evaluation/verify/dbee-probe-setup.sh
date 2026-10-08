#!/usr/bin/env bash
# Introspection SETUP: create user dbee_probe with a known email so the agent can confirm the
# email is decryptable via the user API while stored encrypted in the DB. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\user\Entity\User;
  if (!user_load_by_name("dbee_probe")) {
    User::create(["name"=>"dbee_probe","mail"=>"dbee_probe@example.com","status"=>1])->save();
  }
' >/dev/null 2>&1
echo "setup: user dbee_probe (email dbee_probe@example.com) created"
