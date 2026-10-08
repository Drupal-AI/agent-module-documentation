#!/usr/bin/env bash
# Execution CLEANUP: revoke 'render storybook stories' from anonymous (production-safe default).
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush role:perm:remove anonymous 'render storybook stories' >/dev/null 2>&1
echo "cleanup: anonymous 'render storybook stories' revoked"
