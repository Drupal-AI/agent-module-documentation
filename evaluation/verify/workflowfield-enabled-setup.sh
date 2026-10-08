#!/usr/bin/env bash
# Introspection SETUP: ensure the workflowfield module is enabled so an inspecting agent can report its
# live status/dependencies. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush en workflowfield -y >/dev/null 2>&1
echo "setup: workflowfield enabled"
