#!/usr/bin/env bash
# Execution CLEANUP: remove allow_iframed_site.settings (baseline). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("allow_iframed_site.settings")->delete();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: allow_iframed_site.settings removed"
