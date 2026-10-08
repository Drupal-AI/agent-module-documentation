#!/usr/bin/env bash
# Execution RESET: ensure the anonymous role does NOT have 'render storybook stories' so
# verify FAILS until the agent grants it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush role:perm:remove anonymous 'render storybook stories' >/dev/null 2>&1
echo "reset: anonymous lacks 'render storybook stories'"
