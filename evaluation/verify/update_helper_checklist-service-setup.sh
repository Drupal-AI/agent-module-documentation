#!/usr/bin/env bash
# Introspection SETUP (update_helper_checklist M1): the agent must inspect the live container to
# find the service that marks configuration updates complete and the class behind it. No mutation.
set -uo pipefail
cd /var/www/html
echo "setup: inspect the update_helper_checklist.update_checklist service in the live container"
