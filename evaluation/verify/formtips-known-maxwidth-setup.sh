#!/usr/bin/env bash
# Introspection SETUP: set formtips.settings:formtips_max_width to a known value so an
# inspecting agent can read it back from the live config. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush cset formtips.settings formtips_max_width '321px' -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: formtips.settings formtips_max_width=321px"
