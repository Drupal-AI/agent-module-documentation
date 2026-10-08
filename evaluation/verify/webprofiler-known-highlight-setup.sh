#!/usr/bin/env bash
# Introspection SETUP: set a known slow-query highlight threshold so an agent can read it back.
set -uo pipefail
cd /var/www/html
drush cset -y webprofiler.settings query_highlight 37 >/dev/null 2>&1
echo "setup: webprofiler.settings query_highlight=37"
