#!/usr/bin/env bash
# Introspection SETUP: set a known subscribe_hub_url on the subscriber settings so an agent can
# read it back. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush cset -y entity_share_websub_subscriber.settings subscribe_hub_url '/eswsub-known-hub' >/dev/null 2>&1
echo "setup: subscribe_hub_url=/eswsub-known-hub"
