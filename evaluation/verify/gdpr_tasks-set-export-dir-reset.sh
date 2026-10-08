#!/usr/bin/env bash
# Execution RESET: clear gdpr_tasks.settings so no export directory is set and verify FAILS
# until the agent configures one. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("gdpr_tasks.settings")->delete();' >/dev/null 2>&1
echo "reset: gdpr_tasks.settings cleared"
