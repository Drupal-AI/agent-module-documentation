#!/usr/bin/env bash
# Execution RESET: populate the pcb_clear permanent bin with an entry so it is NON-empty; verify
# FAILS until the agent explicitly flushes the bin. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::service("cache.backend.permanent_database")->get("pcb_clear")->set("pcb_ckey", "PCB_TO_BE_CLEARED");' >/dev/null 2>&1
echo "reset: pcb_clear/pcb_ckey populated"
