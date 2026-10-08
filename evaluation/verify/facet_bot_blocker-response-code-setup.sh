#!/usr/bin/env bash
# Introspection SETUP: enable 410 Gone responses.
set -uo pipefail
cd /var/www/html
drush cset facet_bot_blocker.settings facet_bot_blocker_return_gone 1 -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: facet_bot_blocker.settings.facet_bot_blocker_return_gone=true"
