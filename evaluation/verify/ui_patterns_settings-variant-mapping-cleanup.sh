#!/usr/bin/env bash
# Execution CLEANUP: clear the mapping. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("ui_patterns_settings.settings")->set("mapping", [])->save();' >/dev/null 2>&1
echo "cleanup: ui_patterns_settings.settings mapping cleared"
