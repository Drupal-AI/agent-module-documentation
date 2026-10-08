#!/usr/bin/env bash
# MEDIUM introspection SETUP: put Stripe into 'live' environment with a known live publishable
# key, so an agent inspecting stripe.settings can read them back. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush config:set stripe.settings environment live -y >/dev/null 2>&1
drush config:set stripe.settings apikey.live.public 'pk_live_MEDIUM_marker_001' -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: stripe.settings environment=live, apikey.live.public=pk_live_MEDIUM_marker_001"
