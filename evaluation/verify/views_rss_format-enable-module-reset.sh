#!/usr/bin/env bash
# Execution RESET: disable views_rss_format so verify FAILS until the agent re-enables it.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush pmu views_rss_format -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: views_rss_format disabled"
