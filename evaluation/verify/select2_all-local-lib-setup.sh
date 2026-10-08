#!/usr/bin/env bash
# Introspection SETUP: place a local Select2 library at web/libraries/select2/dist so that
# select2_all_library_info_alter() swaps the CDN copy for the local one. An inspecting agent
# should then see the 'select2' library JS resolve to a local /libraries/... path. Idempotent.
set -uo pipefail
cd /var/www/html
mkdir -p web/libraries/select2/dist/js web/libraries/select2/dist/css
printf '/* select2 local stub */\n' > web/libraries/select2/dist/js/select2.min.js
printf '/* select2 local stub */\n' > web/libraries/select2/dist/css/select2.min.css
drush cr >/dev/null 2>&1
echo "setup: local Select2 library present at web/libraries/select2/dist"
