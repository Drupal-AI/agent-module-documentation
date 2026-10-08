#!/usr/bin/env bash
# Introspection CLEANUP: remove the config object, restoring baseline. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("require_revision_log_message.adminsettings")->delete();' >/dev/null 2>&1
echo "cleanup: require_revision_log_message.adminsettings removed (baseline)"
