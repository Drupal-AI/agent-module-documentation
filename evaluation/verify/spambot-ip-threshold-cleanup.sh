#!/usr/bin/env bash
# Introspection CLEANUP: restore spambot IP threshold to its shipped default (20). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush cset spambot.settings spambot_criteria_ip 20 -y >/dev/null 2>&1
echo "cleanup: spambot.settings spambot_criteria_ip=20 (default)"
