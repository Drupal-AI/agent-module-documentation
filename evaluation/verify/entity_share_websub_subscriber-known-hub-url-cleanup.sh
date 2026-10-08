#!/usr/bin/env bash
# Introspection CLEANUP: restore subscribe_hub_url to its shipped default (empty -> treated as
# /subscribe). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush cset -y entity_share_websub_subscriber.settings subscribe_hub_url '' >/dev/null 2>&1
echo "cleanup: subscribe_hub_url reset to '' (default /subscribe)"
