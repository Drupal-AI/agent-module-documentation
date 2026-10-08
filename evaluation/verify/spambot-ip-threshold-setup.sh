#!/usr/bin/env bash
# Introspection SETUP: set a distinctive spambot IP-address spammer threshold so an inspecting
# agent can read it back from live config. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush cset spambot.settings spambot_criteria_ip 13 -y >/dev/null 2>&1
echo "setup: spambot.settings spambot_criteria_ip=13"
