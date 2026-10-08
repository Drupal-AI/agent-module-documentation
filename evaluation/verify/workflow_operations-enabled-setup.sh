#!/usr/bin/env bash
# Introspection SETUP: ensure the workflow_operations module is enabled so an inspecting agent can report its
# live status/dependencies. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush en workflow_operations -y >/dev/null 2>&1
echo "setup: workflow_operations enabled"
