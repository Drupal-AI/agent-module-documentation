#!/usr/bin/env bash
# Introspection SETUP: ensure entity_events is enabled so the agent can inspect the running
# site's EntityEventType class and read the event name dispatched on entity update. entity_events
# has no site config, so the "known state" here is simply that the module is installed/enabled.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush en entity_events -y >/dev/null 2>&1
echo "setup: entity_events enabled (EntityEventType::UPDATE discoverable on live site)"
