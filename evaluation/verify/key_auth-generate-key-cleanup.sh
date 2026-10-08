#!/usr/bin/env bash
# Execution CLEANUP: delete user ka_client and role ka_role created by the matching reset.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\user\Entity\Role;
  use Drupal\user\Entity\User;

  $uids = \Drupal::entityQuery("user")
    ->accessCheck(FALSE)
    ->condition("name", "ka_client")
    ->execute();
  foreach ($uids as $uid) {
    if ($user = User::load($uid)) {
      $user->delete();
    }
  }
  if ($role = Role::load("ka_role")) {
    $role->delete();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: ka_client user and ka_role role removed"
