#!/usr/bin/env bash
# Introspection SETUP: set linkpurpose.settings:purposeExternalMessage to a known screen-reader
# string so the agent can read it back from live config. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush cset linkpurpose.settings purposeExternalMessage 'Leaves our website' -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: linkpurpose.settings purposeExternalMessage='Leaves our website'"
