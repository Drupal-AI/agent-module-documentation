#!/usr/bin/env bash
# Introspection SETUP: ensure entity_events is enabled so the agent can inspect the running site
# and read the event name dispatched before an entity is deleted (EntityEventType::PREDELETE).
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush en entity_events -y >/dev/null 2>&1
echo "setup: entity_events enabled (EntityEventType::PREDELETE discoverable on live site)"
