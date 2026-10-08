#!/usr/bin/env bash
# Execution RESET: force path_file.settings allowed_extensions to a baseline WITHOUT 'svg', so the
# verify FAILS until the agent adds it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush cset path_file.settings allowed_extensions 'pdf jpg png txt' -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: path_file.settings allowed_extensions = 'pdf jpg png txt' (no svg)"
