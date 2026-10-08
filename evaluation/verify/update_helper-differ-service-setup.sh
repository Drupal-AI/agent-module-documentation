#!/usr/bin/env bash
# Introspection SETUP (update_helper M2): the agent must inspect the live container to find the
# reversible config-diff service update_helper uses and the class behind it. No mutation. Exit 0.
set -uo pipefail
cd /var/www/html
echo "setup: inspect the update_helper.config_differ service in the live container"
