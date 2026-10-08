#!/usr/bin/env bash
# Execution CLEANUP: restore shipped default use_stderr='1'. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush cset -y log_stdout.settings use_stderr 1 >/dev/null 2>&1
echo "cleanup: log_stdout.settings use_stderr=1"
