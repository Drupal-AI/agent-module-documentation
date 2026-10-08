#!/usr/bin/env bash
# Introspection CLEANUP: delete ape.settings to restore baseline (module ships no default
# ape.settings). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("ape.settings")->delete();' >/dev/null 2>&1
echo "cleanup: ape.settings deleted"
