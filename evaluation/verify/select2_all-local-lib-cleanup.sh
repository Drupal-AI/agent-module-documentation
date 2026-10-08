#!/usr/bin/env bash
# Introspection CLEANUP: remove the local Select2 library, restoring the CDN default.
set -uo pipefail
cd /var/www/html
rm -rf web/libraries/select2
drush cr >/dev/null 2>&1
echo "cleanup: local Select2 library removed (back to CDN)"
