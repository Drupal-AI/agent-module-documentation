#!/usr/bin/env bash
# Introspection CLEANUP: restore purposeExternalMessage to the shipped default.
set -uo pipefail
cd /var/www/html
drush cset linkpurpose.settings purposeExternalMessage 'Link is external' -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: linkpurpose.settings purposeExternalMessage restored to 'Link is external'"
