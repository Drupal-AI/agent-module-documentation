#!/usr/bin/env bash
# Execution CLEANUP: delete gtext.settings to restore baseline. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("gtext.settings")->delete();' >/dev/null 2>&1
echo "cleanup: gtext.settings deleted (baseline)"
