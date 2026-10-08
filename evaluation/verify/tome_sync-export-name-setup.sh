#!/usr/bin/env bash
# Introspection SETUP: export node 1 to Tome Sync's JSON content store so the agent can inspect
# the on-disk content directory and report node 1's export filename/uuid. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush tome:export-content 'node:1' >/dev/null 2>&1
echo "setup: exported node 1 -> content/node.5528817f-2211-4569-91a2-af6f5da9da25.json"
