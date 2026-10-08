#!/usr/bin/env bash
# Introspection SETUP (update_helper M1): update_helper stores no config of its own; it is a
# developer tool. The agent must inspect the live container to identify the service that applies
# configuration update definitions and the class it resolves to. No mutation. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
echo "setup: update_helper enabled; inspect the update_helper.updater service in the live container"
