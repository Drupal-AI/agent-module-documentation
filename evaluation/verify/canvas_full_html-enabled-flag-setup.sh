#!/usr/bin/env bash
# Introspection SETUP (canvas_full_html M1): put the module's integration into a known
# state (DISABLED) so the agent must inspect the live config to report it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush cset canvas_full_html.settings enabled 0 -y >/dev/null 2>&1
echo "setup: canvas_full_html.settings:enabled = false"
