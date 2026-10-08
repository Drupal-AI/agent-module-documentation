#!/usr/bin/env bash
# Execution RESET: force spambot username checking OFF (spambot_criteria_username=0) so verify FAILS
# until the agent sets the requested threshold. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush cset spambot.settings spambot_criteria_username 0 -y >/dev/null 2>&1
echo "reset: spambot.settings spambot_criteria_username=0"
