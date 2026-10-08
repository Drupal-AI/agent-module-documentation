#!/usr/bin/env bash
# Introspection SETUP: set the facet depth limit to 3.
set -uo pipefail
cd /var/www/html
drush cset facet_bot_blocker.settings facets_bot_blocker_limit 3 -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: facet_bot_blocker.settings.facets_bot_blocker_limit=3"
