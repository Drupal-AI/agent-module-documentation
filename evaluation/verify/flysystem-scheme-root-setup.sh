#!/usr/bin/env bash
# Introspection SETUP: declare a Flysystem scheme 'flyroot' whose local root is a known,
# distinctive path so the agent can read the configured root back. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
python3 agent-module-documentation/evaluation/verify/flysystem-settings-edit.py add flyroot 'sites/default/files/flysystem-eval-data' 0
drush cr >/dev/null 2>&1
echo "setup: flyroot root=sites/default/files/flysystem-eval-data"
