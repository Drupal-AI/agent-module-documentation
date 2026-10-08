#!/usr/bin/env bash
# Introspection SETUP: create cron_migration mqi_flags with the 'sync' flag enabled (update and
# ignore_dependencies off), so an agent can read back which flags are set. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $s = \Drupal::entityTypeManager()->getStorage("cron_migration");
  if ($e = $s->load("mqi_flags")) { $e->delete(); }
  $s->create([
    "id" => "mqi_flags", "label" => "Flags import",
    "migration" => "mqi_other_migration", "time" => 0,
    "update" => FALSE, "sync" => TRUE, "ignore_dependencies" => FALSE, "status" => TRUE,
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: cron_migration mqi_flags has sync=TRUE (update/ignore off)"
