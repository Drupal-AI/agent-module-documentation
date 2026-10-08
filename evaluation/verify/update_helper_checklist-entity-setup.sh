#!/usr/bin/env bash
# Introspection SETUP (update_helper_checklist M2): the agent must inspect the live entity-type
# definitions to find the entity that tracks per-update-hook completion status. No mutation.
set -uo pipefail
cd /var/www/html
echo "setup: inspect the entity types provided by update_helper_checklist in the live container"
