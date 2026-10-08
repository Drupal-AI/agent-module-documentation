#!/usr/bin/env bash
# Execution RESET: ensure NO 'flypub' scheme is configured. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
python3 agent-module-documentation/evaluation/verify/flysystem-settings-edit.py remove flypub
rm -rf web/sites/default/files/flysystem-pub 2>/dev/null
drush cr >/dev/null 2>&1
echo "reset: flypub scheme absent"
