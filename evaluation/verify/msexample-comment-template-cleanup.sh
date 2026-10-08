#!/usr/bin/env bash
# Introspection CLEANUP (message_subscribe_example): uninstall the example submodule to restore the
# shared-site baseline (its hooks fire on every node/comment/user insert). Exit 0.
set -uo pipefail
cd /var/www/html
drush -y pmu message_subscribe_example >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: message_subscribe_example uninstalled (baseline)"
