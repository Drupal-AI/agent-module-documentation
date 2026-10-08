#!/usr/bin/env bash
# Execution RESET: force global dedupe OFF (0) so verify FAILS until the agent enables strict
# de-duplication. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush config:set filehash.settings dedupe 0 -y >/dev/null 2>&1
echo "reset: filehash.settings dedupe=0 (off)"
