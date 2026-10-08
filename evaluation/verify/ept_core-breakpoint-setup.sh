#!/usr/bin/env bash
# Introspection SETUP: set the EPT mobile breakpoint to a known value. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("ept_core.settings")->set("ept_core_mobile_breakpoint", "600")->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: ept_core.settings ept_core_mobile_breakpoint = 600"
