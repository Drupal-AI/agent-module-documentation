#!/usr/bin/env bash
# Execution CLEANUP: delete the tm_access_user account, the tm_access_role role and the
# tm_access vocabulary created by the reset. Restores baseline. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\taxonomy\Entity\Vocabulary;
  use Drupal\user\Entity\Role;
  foreach (\Drupal::entityTypeManager()->getStorage("user")
    ->loadByProperties(["name" => "tm_access_user"]) as $u) { $u->delete(); }
  if ($r = Role::load("tm_access_role")) { $r->delete(); }
  if ($v = Vocabulary::load("tm_access")) { $v->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: user tm_access_user, role tm_access_role and vocabulary tm_access removed"
