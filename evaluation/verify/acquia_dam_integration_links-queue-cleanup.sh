#!/usr/bin/env bash
# Introspection CLEANUP: delete the acquia_dam_integration_links queue (removes marker items),
# restoring baseline (empty). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::queue("acquia_dam_integration_links")->deleteQueue();' >/dev/null 2>&1
echo "cleanup: acquia_dam_integration_links queue deleted"
