#!/usr/bin/env bash
# Introspection SETUP: ensure the dubbot_toolbar submodule is enabled so the agent can detect
# which module provides the DubBot toolbar item. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush en dubbot_toolbar -y >/dev/null 2>&1
echo "setup: dubbot_toolbar enabled"
