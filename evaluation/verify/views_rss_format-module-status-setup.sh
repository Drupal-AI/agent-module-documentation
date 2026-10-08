#!/usr/bin/env bash
# Introspection SETUP: disable views_rss_format so an inspecting agent must discover it is
# currently OFF (rather than assuming the common "probably enabled" baseline). Idempotent.
# Exit 0.
set -uo pipefail
cd /var/www/html
drush pmu views_rss_format -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: views_rss_format disabled"
