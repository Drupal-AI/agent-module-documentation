#!/usr/bin/env bash
# Execution CLEANUP: clear pcb_task and drop its table. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::service("cache.backend.permanent_database")->get("pcb_task")->deleteAllPermanent(); if (\Drupal::database()->schema()->tableExists("cache_pcb_task")) { \Drupal::database()->schema()->dropTable("cache_pcb_task"); }' >/dev/null 2>&1
echo "cleanup: pcb_task bin cleared and table dropped"
