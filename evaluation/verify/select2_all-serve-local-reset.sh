#!/usr/bin/env bash
# Execution RESET: ensure NO local Select2 library exists, so the 'select2' library resolves
# to the CDN and verify FAILs until the agent installs it locally. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
rm -rf web/libraries/select2
drush cr >/dev/null 2>&1
echo "reset: no local Select2 library (CDN default)"
