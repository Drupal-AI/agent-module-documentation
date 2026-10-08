#!/usr/bin/env bash
# Introspection CLEANUP: remove the purgers entry (baseline: no purgers registered). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '$c=\Drupal::configFactory()->getEditable("purge.plugins"); $c->clear("purgers"); $c->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: purge.plugins purgers cleared"
