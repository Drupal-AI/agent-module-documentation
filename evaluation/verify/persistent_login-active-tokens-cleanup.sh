#!/usr/bin/env bash
# Introspection CLEANUP: delete the user created by the setup (which also clears its tokens
# via hook_user_delete). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  if ($u = user_load_by_name("pl_known_user")) {
    \Drupal::service("persistent_login.token_manager")->clearUsersTokens($u);
    $u->delete();
  }
' >/dev/null 2>&1
echo "cleanup: user pl_known_user and its persistent login tokens removed"
