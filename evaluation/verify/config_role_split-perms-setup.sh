#!/usr/bin/env bash
# Introspection SETUP: create role_split crs_perms (mode=split) managing one permission on the
# authenticated role, so an agent can read back which permission is filtered. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $s = \Drupal::entityTypeManager()->getStorage("role_split");
  if (!$s->load("crs_perms")) {
    $s->create([
      "id" => "crs_perms", "label" => "Perms split",
      "weight" => 0, "status" => TRUE, "mode" => "split",
      "roles" => ["authenticated" => ["access user profiles"]],
    ])->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: role_split crs_perms manages authenticated -> access user profiles"
