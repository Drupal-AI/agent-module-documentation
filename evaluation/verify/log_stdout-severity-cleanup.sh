#!/usr/bin/env bash
# Introspection CLEANUP: restore Log Stdout shipped defaults (severity_level=3,
# use_stderr='1'). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush cset -y log_stdout.settings severity_level 3 >/dev/null 2>&1
drush cset -y log_stdout.settings use_stderr 1 >/dev/null 2>&1
echo "cleanup: log_stdout.settings restored (severity_level=3, use_stderr=1)"
