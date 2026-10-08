#!/usr/bin/env bash
# Execution RESET: enable the deprecated views_dependent_filter module so the desired end
# state (module removed) is NOT yet met -- verify FAILS until the agent uninstalls it.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush en views_dependent_filter -y >/dev/null 2>&1
echo "reset: deprecated module views_dependent_filter enabled (should be uninstalled)"
