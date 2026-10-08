#!/usr/bin/env bash
# Medium cleanup: restore jsonapi.settings.read_only to the site baseline (TRUE, which is
# JSON:API's safe default). Shared by both read-only introspection cases.
set -uo pipefail
cd /var/www/html
drush cset jsonapi.settings read_only 1 -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: jsonapi.settings.read_only restored to TRUE (baseline)"
