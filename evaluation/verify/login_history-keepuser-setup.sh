#!/usr/bin/env bash
# Introspection SETUP: set login_history keep_user to a distinctive known value so an
# inspecting agent can read it back from live config. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush cset login_history.settings keep_user 13 -y >/dev/null 2>&1
echo "setup: login_history.settings keep_user=13"
