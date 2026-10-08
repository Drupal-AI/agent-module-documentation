#!/usr/bin/env bash
# Execution RESET for "enable content-view counting". Forces the WRONG baseline so verify FAILS
# until the agent fixes it: statistics.settings:count_content_views = 0 (counting OFF).
# The agent must switch it on (set count_content_views = 1) in live config. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush cset statistics.settings count_content_views 0 -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: statistics.settings count_content_views = 0 (agent must enable it)"
