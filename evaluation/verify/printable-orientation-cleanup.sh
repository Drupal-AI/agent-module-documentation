#!/usr/bin/env bash
# Execution CLEANUP: restore printable.settings.page_orientation to Portrait (default).
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush cset printable.settings page_orientation Portrait -y >/dev/null 2>&1
echo "cleanup: printable.settings page_orientation restored to Portrait"
