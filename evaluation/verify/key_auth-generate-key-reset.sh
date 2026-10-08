#!/usr/bin/env bash
# Execution RESET: ensure role ka_role (with 'use key authentication') and user ka_client
# exist, then force ka_client's api_key to NULL so verify FAILS on baseline. (Creating the
# user with auto_generate_keys default TRUE would otherwise auto-populate api_key, so we
# explicitly null it out after creation.) Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\user\Entity\Role;
  use Drupal\user\Entity\User;

  $role = Role::load("ka_role");
  if (!$role) {
    $role = Role::create(["id" => "ka_role", "label" => "Key Auth Client"]);
  }
  if (!$role->hasPermission("use key authentication")) {
    $role->grantPermission("use key authentication");
  }
  $role->save();

  $uids = \Drupal::entityQuery("user")
    ->accessCheck(FALSE)
    ->condition("name", "ka_client")
    ->execute();
  if ($uids) {
    $user = User::load(reset($uids));
  }
  else {
    $user = User::create([
      "name" => "ka_client",
      "mail" => "ka_client@example.com",
      "status" => 1,
    ]);
  }
  $user->addRole("ka_role");
  $user->activate();
  $user->save();

  // Force api_key to NULL so the baseline fails verify (auto_generate_keys may have
  // populated it on creation).
  $user->set("api_key", NULL)->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: user ka_client + role ka_role present, api_key forced NULL"
