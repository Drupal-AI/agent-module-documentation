#!/usr/bin/env bash
# Introspection SETUP: set a known EBT background color in ebt_core.settings so the agent can
# read it back from the live config. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush cset ebt_core.settings ebt_core_background_color '#abcdef' -y >/dev/null 2>&1
echo "setup: ebt_core.settings ebt_core_background_color=#abcdef"
