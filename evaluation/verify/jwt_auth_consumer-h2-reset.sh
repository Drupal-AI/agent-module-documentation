#!/usr/bin/env bash
# Execution RESET: create+BLOCK a namespaced user jwtcons_task (status 0). The task asks the
# agent to make it so jwt_auth_consumer would accept a JWT for this user (i.e. unblock/activate
# it); verify must FAIL against this reset (blocked) state. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\user\Entity\User;
  $existing = user_load_by_name("jwtcons_task");
  if ($existing) { $existing->delete(); }
  User::create([
    "name" => "jwtcons_task",
    "mail" => "jwtcons_task@example.com",
    "status" => 0,
  ])->save();
' >/dev/null 2>&1
echo "reset: user jwtcons_task created with status=0 (blocked, baseline)"
