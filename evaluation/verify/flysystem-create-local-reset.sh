#!/usr/bin/env bash
# Execution RESET: ensure NO 'flytask' Flysystem scheme is configured, so verify FAILS until
# the agent declares it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
python3 agent-module-documentation/evaluation/verify/flysystem-settings-edit.py remove flytask
rm -rf web/sites/default/files/flysystem-flytask 2>/dev/null
drush cr >/dev/null 2>&1
echo "reset: flytask scheme absent"
