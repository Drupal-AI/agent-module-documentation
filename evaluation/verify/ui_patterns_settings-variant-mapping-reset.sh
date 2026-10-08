#!/usr/bin/env bash
# Execution RESET: clear the mapping so verify FAILS until the agent binds a field to a pattern
# variant. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("ui_patterns_settings.settings")->set("mapping", [])->save();' >/dev/null 2>&1
echo "reset: ui_patterns_settings.settings mapping cleared"
