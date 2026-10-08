#!/usr/bin/env bash
# Execution RESET: clear the require_revision_log_message config so NO content type requires a
# log message (verify must FAIL until the agent adds Article). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("require_revision_log_message.adminsettings")->delete();' >/dev/null 2>&1
echo "reset: require_revision_log_message config cleared (no content type required)"
