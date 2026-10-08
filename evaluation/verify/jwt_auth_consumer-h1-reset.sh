#!/usr/bin/env bash
# Execution RESET: disable jwt_auth_consumer, so the site does NOT accept issuer tokens. The
# task asks the agent to enable it again; verify must FAIL against this reset state. Idempotent
# (safe if already disabled). Exit 0.
set -uo pipefail
cd /var/www/html
drush -y pmu jwt_auth_consumer >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: jwt_auth_consumer disabled"
