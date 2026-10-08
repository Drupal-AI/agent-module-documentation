#!/usr/bin/env bash
# Introspection CLEANUP: delete both eval roles. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\user\Entity\Role;
  foreach (["social_api_eval_admin", "social_api_eval_poster"] as $id) {
    if ($r = Role::load($id)) { $r->delete(); }
  }
' >/dev/null 2>&1
echo "cleanup: social_api eval roles deleted"
