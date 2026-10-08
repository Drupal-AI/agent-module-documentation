#!/usr/bin/env bash
# Introspection SETUP: cache a known value in a pcb permanent database bin so the agent can read
# it back. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::service("cache.backend.permanent_database")->get("pcb_med")->set("pcb_mkey", "PCB_MEDIUM_TOKEN");' >/dev/null 2>&1
echo "setup: pcb_med/pcb_mkey = PCB_MEDIUM_TOKEN"
