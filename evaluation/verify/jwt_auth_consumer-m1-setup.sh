#!/usr/bin/env bash
# Introspection SETUP: create a BLOCKED namespaced user jwtcons_blocked (status 0), so an
# inspecting agent can check its status and correctly say jwt_auth_consumer would NOT accept a
# JWT naming this user (its validate() rejects blocked users). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\user\Entity\User;
  $existing = user_load_by_name("jwtcons_blocked");
  if ($existing) { $existing->delete(); }
  User::create([
    "name" => "jwtcons_blocked",
    "mail" => "jwtcons_blocked@example.com",
    "status" => 0,
  ])->save();
' >/dev/null 2>&1
echo "setup: user jwtcons_blocked created with status=0 (blocked)"
