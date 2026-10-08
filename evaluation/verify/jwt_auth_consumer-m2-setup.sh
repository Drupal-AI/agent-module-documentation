#!/usr/bin/env bash
# Introspection SETUP: create an ACTIVE namespaced user jwtcons_active (status 1), so an
# inspecting agent can confirm jwt_auth_consumer WOULD accept a JWT naming this user (exists,
# not blocked) and name the claim(s) that resolve it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\user\Entity\User;
  $existing = user_load_by_name("jwtcons_active");
  if ($existing) { $existing->delete(); }
  User::create([
    "name" => "jwtcons_active",
    "mail" => "jwtcons_active@example.com",
    "status" => 1,
  ])->save();
' >/dev/null 2>&1
echo "setup: user jwtcons_active created with status=1 (active)"
