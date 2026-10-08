#!/usr/bin/env bash
# Introspection SETUP: ensure a user with email fpc_known@example.com exists and flag a pending
# forced password change for it via the force_password_change service (writes user.data
# pending_force=1). NOTE: this site forces username = email, so we key on mail. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\user\Entity\User;
  $s = \Drupal::entityTypeManager()->getStorage("user");
  $ex = $s->loadByProperties(["mail" => "fpc_known@example.com"]);
  $u = $ex ? reset($ex) : NULL;
  if (!$u) {
    $u = User::create(["name" => "fpc_known", "mail" => "fpc_known@example.com", "status" => 1]);
    $u->save();
  }
  \Drupal::service("force_password_change.service")->forceUsersPasswordChange([$u->id()]);
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: user fpc_known@example.com has pending_force=1"
