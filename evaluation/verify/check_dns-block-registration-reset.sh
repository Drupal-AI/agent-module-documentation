#!/usr/bin/env bash
# Execution RESET (check_dns): uninstall check_dns so its registration validate handler
# is NOT wired. In this state verify MUST FAIL (registrations with a bad email domain
# are no longer blocked). The agent's task is to enable check_dns. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush -y pmu check_dns >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: check_dns uninstalled (registration domain check is OFF)"
