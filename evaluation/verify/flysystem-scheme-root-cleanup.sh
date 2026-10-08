#!/usr/bin/env bash
# Introspection CLEANUP: remove the flyroot scheme and its dir. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
python3 agent-module-documentation/evaluation/verify/flysystem-settings-edit.py remove flyroot
rm -rf web/sites/default/files/flysystem-eval-data 2>/dev/null
drush cr >/dev/null 2>&1
echo "cleanup: flyroot scheme removed"
