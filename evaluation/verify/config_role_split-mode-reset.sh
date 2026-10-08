#!/usr/bin/env bash
# Execution RESET: (re)create role_split crs_mode with mode=split, so verify (wants fork) FAILS
# until the agent changes the mode. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $s = \Drupal::entityTypeManager()->getStorage("role_split");
  $e = $s->load("crs_mode");
  if (!$e) {
    $e = $s->create(["id" => "crs_mode", "label" => "Mode change split",
      "weight" => 0, "status" => TRUE, "mode" => "split",
      "roles" => ["authenticated" => ["access content"]]]);
  }
  $e->set("mode", "split")->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: role_split crs_mode present with mode=split"
