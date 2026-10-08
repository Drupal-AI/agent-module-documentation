#!/usr/bin/env bash
# Introspection SETUP: set a known EBT mobile breakpoint so the agent can read it back. Exit 0.
set -uo pipefail
cd /var/www/html
drush cset ebt_core.settings ebt_core_mobile_breakpoint '555' -y >/dev/null 2>&1
echo "setup: ebt_core.settings ebt_core_mobile_breakpoint=555"
