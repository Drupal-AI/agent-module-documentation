#!/usr/bin/env bash
# Execution CLEANUP: remove all purgers (restore baseline: no purgers). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("purge.plugins")->set("purgers", [])->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: purge.plugins purgers cleared"
