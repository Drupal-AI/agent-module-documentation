#!/usr/bin/env bash
# Introspection SETUP: place a swagger-ui distribution at the exact path the module's
# libraries.yml points at (<docroot>/libraries/swagger-ui/dist/...), with a package.json
# declaring a known version, so an inspecting agent can report whether the library is
# installed and which version. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
LIB=web/libraries/swagger-ui
mkdir -p "$LIB/dist"
printf '%s\n' '{"name":"swagger-ui-dist","version":"5.29.3","license":"Apache-2.0"}' > "$LIB/package.json"
printf '%s\n' '/* swagger-ui-bundle placeholder for eval */' > "$LIB/dist/swagger-ui-bundle.js"
printf '%s\n' '/* swagger-ui-standalone-preset placeholder for eval */' > "$LIB/dist/swagger-ui-standalone-preset.js"
printf '%s\n' '/* swagger-ui css placeholder for eval */' > "$LIB/dist/swagger-ui.css"
drush cr >/dev/null 2>&1
echo "setup: swagger-ui 5.29.3 present at web/libraries/swagger-ui"
