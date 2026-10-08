#!/usr/bin/env bash
# Introspection SETUP: create user dbee_finder with a known email, so the agent must use an
# email look-up (which dbee's query alter makes work over encrypted storage) to find the uid.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\user\Entity\User;
  if (!user_load_by_name("dbee_finder")) {
    User::create(["name"=>"dbee_finder","mail"=>"dbee_find@example.com","status"=>1])->save();
  }
' >/dev/null 2>&1
echo "setup: user dbee_finder (email dbee_find@example.com) created"
