#!/usr/bin/env bash
# Execution CLEANUP: restore shipped defaults (enable_debug_mode=FALSE, selector='').
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("quicklink.settings")->set("enable_debug_mode", FALSE)->set("selector", "")->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: quicklink debug/selector defaults restored"
