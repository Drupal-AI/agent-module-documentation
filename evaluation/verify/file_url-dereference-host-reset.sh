#!/usr/bin/env bash
# Execution RESET: force file_url.settings dereference_host back to its shipped default (empty
# string), so verify FAILs until the agent sets a canonical host. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush cset file_url.settings dereference_host '' -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: file_url.settings dereference_host = '' (shipped default)"
