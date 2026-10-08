#!/usr/bin/env bash
# HARD execution RESET: force shipped defaults (environment=test, empty live public key) so
# verify FAILs until the agent switches Stripe to live with the live publishable key. Exit 0.
set -uo pipefail
cd /var/www/html
drush config:set stripe.settings environment test -y >/dev/null 2>&1
drush config:set stripe.settings apikey.live.public '' -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: stripe.settings environment=test, apikey.live.public empty"
