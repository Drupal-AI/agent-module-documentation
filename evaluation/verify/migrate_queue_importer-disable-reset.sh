#!/usr/bin/env bash
# Execution RESET: (re)create cron_migration mqi_toggle ENABLED, so verify (wants disabled)
# FAILS until the agent disables it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $s = \Drupal::entityTypeManager()->getStorage("cron_migration");
  if ($e = $s->load("mqi_toggle")) { $e->delete(); }
  $s->create([
    "id" => "mqi_toggle", "label" => "Toggle import",
    "migration" => "mqi_toggle_migration", "time" => 1800,
    "update" => FALSE, "sync" => FALSE, "ignore_dependencies" => FALSE, "status" => TRUE,
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: cron_migration mqi_toggle present and ENABLED"
