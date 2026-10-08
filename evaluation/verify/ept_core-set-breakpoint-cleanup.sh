#!/usr/bin/env bash
# Execution CLEANUP: restore default desktop breakpoint. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("ept_core.settings")->set("ept_core_desktop_breakpoint", "1320")->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: ept_core.settings ept_core_desktop_breakpoint = 1320 (default)"
