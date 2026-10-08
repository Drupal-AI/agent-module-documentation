#!/usr/bin/env bash
# Execution RESET: ensure a user with email fpc_task@example.com exists and has NO pending forced
# change (clear its user.data) so verify FAILS until the agent forces it. Site forces name=email,
# so we key on mail. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\user\Entity\User;
  $s = \Drupal::entityTypeManager()->getStorage("user");
  $ex = $s->loadByProperties(["mail" => "fpc_task@example.com"]);
  $u = $ex ? reset($ex) : NULL;
  if (!$u) {
    $u = User::create(["name" => "fpc_task", "mail" => "fpc_task@example.com", "status" => 1]);
    $u->save();
  }
  \Drupal::service("user.data")->delete("force_password_change", $u->id());
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: user fpc_task@example.com present, pending force cleared"
