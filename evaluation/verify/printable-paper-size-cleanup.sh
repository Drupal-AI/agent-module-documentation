#!/usr/bin/env bash
# Introspection CLEANUP: restore printable.settings.paper_size to its shipped default (A4).
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush cset printable.settings paper_size A4 -y >/dev/null 2>&1
echo "cleanup: printable.settings paper_size restored to A4 (default)"
