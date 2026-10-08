#!/usr/bin/env bash
# Execution RESET: uninstall jquery_deprecated_functions so the shims/library are NOT present
# (verify must FAIL until the agent installs it). Nothing depends on this module. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush pm:uninstall jquery_deprecated_functions -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: jquery_deprecated_functions uninstalled"
