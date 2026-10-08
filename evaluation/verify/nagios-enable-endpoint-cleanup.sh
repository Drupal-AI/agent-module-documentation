#!/usr/bin/env bash
# Execution CLEANUP: restore Nagios status page defaults (disabled, path 'nagios'). Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("nagios.settings")
    ->set("nagios.statuspage.enabled", FALSE)
    ->set("nagios.statuspage.path", "nagios")
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: nagios status page restored to defaults"
