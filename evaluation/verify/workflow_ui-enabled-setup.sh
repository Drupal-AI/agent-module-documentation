#!/usr/bin/env bash
# Introspection SETUP: ensure the workflow_ui module is enabled so an inspecting agent can report its
# live status/dependencies. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush en workflow_ui -y >/dev/null 2>&1
echo "setup: workflow_ui enabled"
