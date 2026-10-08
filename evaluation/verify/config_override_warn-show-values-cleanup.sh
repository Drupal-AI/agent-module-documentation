#!/usr/bin/env bash
# Introspection CLEANUP: restore config_override_warn.settings:show_values to its shipped
# default TRUE. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush config:set config_override_warn.settings show_values 1 -y >/dev/null 2>&1
drush config:get config_override_warn.settings show_values 2>/dev/null
echo "cleanup: config_override_warn.settings show_values=TRUE (default)"
