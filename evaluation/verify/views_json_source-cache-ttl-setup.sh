#!/usr/bin/env bash
# Introspection SETUP: set the Views JSON Source cache_ttl to a known, non-default value (120)
# so an agent can read the configured cache duration back. Idempotent.
set -uo pipefail
cd /var/www/html
drush cset views_json_source.settings cache_ttl 120 -y >/dev/null 2>&1
echo "setup: views_json_source.settings cache_ttl = 120"
