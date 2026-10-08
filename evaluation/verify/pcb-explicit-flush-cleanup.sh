#!/usr/bin/env bash
# Execution CLEANUP: clear pcb_clear and drop its table. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::service("cache.backend.permanent_database")->get("pcb_clear")->deleteAllPermanent(); if (\Drupal::database()->schema()->tableExists("cache_pcb_clear")) { \Drupal::database()->schema()->dropTable("cache_pcb_clear"); }' >/dev/null 2>&1
echo "cleanup: pcb_clear bin cleared and table dropped"
