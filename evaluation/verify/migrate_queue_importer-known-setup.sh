#!/usr/bin/env bash
# Introspection SETUP: create a cron_migration entity mqi_known referencing a known migration id
# with a known interval, so an agent can read them back. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $s = \Drupal::entityTypeManager()->getStorage("cron_migration");
  if ($e = $s->load("mqi_known")) { $e->delete(); }
  $s->create([
    "id" => "mqi_known", "label" => "Known scheduled import",
    "migration" => "mqi_sample_migration", "time" => 3600,
    "update" => TRUE, "sync" => FALSE, "ignore_dependencies" => FALSE, "status" => TRUE,
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: cron_migration mqi_known -> migration mqi_sample_migration, time 3600"
