#!/usr/bin/env bash
# Execution RESET: force enable_debug_mode FALSE and clear selector, so verify FAILS until the
# agent turns debug on and sets the parent selector. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("quicklink.settings")->set("enable_debug_mode", FALSE)->set("selector", "")->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: quicklink enable_debug_mode=FALSE, selector=''"
