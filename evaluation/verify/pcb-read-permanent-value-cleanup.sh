#!/usr/bin/env bash
# Introspection CLEANUP: clear the permanent bin and drop its table. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::service("cache.backend.permanent_database")->get("pcb_med")->deleteAllPermanent(); if (\Drupal::database()->schema()->tableExists("cache_pcb_med")) { \Drupal::database()->schema()->dropTable("cache_pcb_med"); }' >/dev/null 2>&1
echo "cleanup: pcb_med bin cleared and table dropped"
