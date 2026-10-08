#!/usr/bin/env bash
# Introspection SETUP: flip config_override_warn.settings:show_values to FALSE (the shipped
# default is TRUE) so the agent must read the live config instead of reciting the default.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush config:set config_override_warn.settings show_values 0 -y >/dev/null 2>&1
drush config:get config_override_warn.settings show_values 2>/dev/null
echo "setup: config_override_warn.settings show_values=FALSE"
