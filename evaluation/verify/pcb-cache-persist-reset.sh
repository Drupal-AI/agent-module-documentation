#!/usr/bin/env bash
# Execution RESET: ensure the pcb_task permanent bin is EMPTY (drop its table) so verify FAILS
# until the agent caches the entry. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval 'if (\Drupal::database()->schema()->tableExists("cache_pcb_task")) { \Drupal::database()->schema()->dropTable("cache_pcb_task"); }' >/dev/null 2>&1
echo "reset: pcb_task bin emptied (table dropped)"
