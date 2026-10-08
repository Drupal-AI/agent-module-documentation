#!/usr/bin/env bash
# Execution CLEANUP: restore file_url.settings dereference_host to shipped default ''. Exit 0.
set -uo pipefail
cd /var/www/html
drush cset file_url.settings dereference_host '' -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: file_url.settings dereference_host reset to ''"
