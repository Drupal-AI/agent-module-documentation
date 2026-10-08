#!/usr/bin/env bash
# Introspection CLEANUP (medium): disable theme development mode again, restoring baseline.
# Idempotent. Exits 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::service("plugin.manager.config_action")
    ->applyAction("themeDevelopmentMode", "system.theme", FALSE);
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: theme development mode disabled"
