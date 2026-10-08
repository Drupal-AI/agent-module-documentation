#!/usr/bin/env bash
# Introspection SETUP: create a user and issue two real persistent-login tokens for it via
# the module's own token manager, so an agent can inspect live token state. Idempotent.
# Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\user\Entity\User;
  $u = user_load_by_name("pl_known_user");
  if (!$u) {
    $u = User::create(["name" => "pl_known_user", "mail" => "pl_known_user@example.com", "status" => 1]);
    $u->save();
  }
  $tm = \Drupal::service("persistent_login.token_manager");
  $tm->clearUsersTokens($u);
  $tm->createNewTokenForUser($u->id());
  $tm->createNewTokenForUser($u->id());
' >/dev/null 2>&1
echo "setup: user pl_known_user has 2 persistent login tokens"
