#!/usr/bin/env bash
# Execution RESET: force config_override_warn.settings:show_values back to TRUE (the shipped
# default), so the matching verify FAILS until the agent turns value display off.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("config_override_warn.settings")->set("show_values", TRUE)->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: show_values=TRUE"
