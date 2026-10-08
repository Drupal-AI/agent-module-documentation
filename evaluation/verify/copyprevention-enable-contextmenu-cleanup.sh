#!/usr/bin/env bash
# Execution CLEANUP: clear copyprevention_body (baseline). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("copyprevention.settings")->clear("copyprevention_body")->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: copyprevention_body cleared"
