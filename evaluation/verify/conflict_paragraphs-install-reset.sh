#!/usr/bin/env bash
# Execution RESET: uninstall conflict_paragraphs so verify FAILS until the agent enables it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush pmu conflict_paragraphs -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: conflict_paragraphs uninstalled"
