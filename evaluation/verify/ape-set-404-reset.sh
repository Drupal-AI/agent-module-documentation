#!/usr/bin/env bash
# Execution RESET: write ape.settings with lifetime.404 = 0 so verify FAILS until the agent
# sets it to 300. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("ape.settings")
    ->set("alternatives", "")
    ->set("exclusions", "")
    ->set("lifetime.alternatives", 300)
    ->set("lifetime.301", 86400)
    ->set("lifetime.302", 3600)
    ->set("lifetime.404", 0)
    ->save();
' >/dev/null 2>&1
echo "reset: ape.settings lifetime.404=0"
