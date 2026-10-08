#!/usr/bin/env bash
# Execution CLEANUP: remove gdpr_tasks.settings config. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("gdpr_tasks.settings")->delete();' >/dev/null 2>&1
echo "cleanup: gdpr_tasks.settings removed"
