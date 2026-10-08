#!/usr/bin/env bash
# Introspection SETUP: write ape.settings with a distinctive 404 cache lifetime (600s) so an
# agent can read it back. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("ape.settings")
    ->set("alternatives", "")
    ->set("exclusions", "")
    ->set("lifetime.alternatives", 300)
    ->set("lifetime.301", 86400)
    ->set("lifetime.302", 3600)
    ->set("lifetime.404", 600)
    ->save();
' >/dev/null 2>&1
echo "setup: ape.settings lifetime.404=600"
