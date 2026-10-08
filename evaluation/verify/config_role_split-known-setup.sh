#!/usr/bin/env bash
# Introspection SETUP: create a role_split config entity crs_known (mode=exclude) so an agent
# can read back its mode from the live config. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $s = \Drupal::entityTypeManager()->getStorage("role_split");
  if (!$s->load("crs_known")) {
    $s->create([
      "id" => "crs_known", "label" => "Known exclude split",
      "weight" => 0, "status" => TRUE, "mode" => "exclude",
      "roles" => ["authenticated" => ["access content"]],
    ])->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: role_split crs_known (mode=exclude) created"
