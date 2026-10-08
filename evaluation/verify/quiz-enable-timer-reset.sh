#!/usr/bin/env bash
# Execution RESET: force quiz.settings has_timer to its shipped default FALSE, so verify
# FAILS until the agent enables the global quiz timer. Also restores baseline when run at the
# end. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush cset quiz.settings has_timer 0 -y >/dev/null 2>&1
echo "reset: quiz.settings has_timer = false"
