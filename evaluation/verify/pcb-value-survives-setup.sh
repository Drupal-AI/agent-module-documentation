#!/usr/bin/env bash
# Introspection SETUP: cache a known value in permanent bin pcb_med2, then call deleteAll()
# (rebuild semantics, a no-op for pcb) so the value remains. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $bin = \Drupal::service("cache.backend.permanent_database")->get("pcb_med2");
  $bin->set("pcb_mkey2", "PCB_SURVIVED_TOKEN");
  $bin->deleteAll();  // no-op for a permanent bin
' >/dev/null 2>&1
echo "setup: pcb_med2/pcb_mkey2 = PCB_SURVIVED_TOKEN (deleteAll called, value retained)"
