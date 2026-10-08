#!/usr/bin/env bash
# Introspection SETUP: ensure jquery_deprecated_functions is enabled and the library registry is
# rebuilt so the global-scripts library is discoverable on the running site. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush pm:install jquery_deprecated_functions -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: jquery_deprecated_functions enabled; library registry rebuilt"
