#!/usr/bin/env bash
# Execution CLEANUP: remove the local Select2 library (mirror of reset). Idempotent. Exit 0.
# to the CDN and verify FAILs until the agent installs it locally. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
rm -rf web/libraries/select2
drush cr >/dev/null 2>&1
echo "cleanup: no local Select2 library (CDN default)"
