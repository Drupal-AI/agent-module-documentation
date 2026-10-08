#!/usr/bin/env bash
# Introspection SETUP: set a known icon-font CSS path in linkicon.settings so an agent can
# read it back. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush cset linkicon.settings font '/libraries/li-eval/fontello.css' -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: linkicon.settings font=/libraries/li-eval/fontello.css"
