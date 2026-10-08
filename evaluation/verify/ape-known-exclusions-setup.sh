#!/usr/bin/env bash
# Introspection SETUP: write ape.settings with a distinctive list of excluded (never-cached)
# paths so an agent can read one back. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("ape.settings")
    ->set("alternatives", "")
    ->set("exclusions", "/ape_exclude\n/user/*")
    ->set("lifetime.alternatives", 300)
    ->set("lifetime.301", 86400)
    ->set("lifetime.302", 3600)
    ->set("lifetime.404", 600)
    ->save();
' >/dev/null 2>&1
echo "setup: ape.settings exclusions=/ape_exclude,/user/*"
