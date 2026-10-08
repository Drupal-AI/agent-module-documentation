#!/usr/bin/env bash
# Introspection CLEANUP: clear pcb_med2 and drop its table. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::service("cache.backend.permanent_database")->get("pcb_med2")->deleteAllPermanent(); if (\Drupal::database()->schema()->tableExists("cache_pcb_med2")) { \Drupal::database()->schema()->dropTable("cache_pcb_med2"); }' >/dev/null 2>&1
echo "cleanup: pcb_med2 bin cleared and table dropped"
