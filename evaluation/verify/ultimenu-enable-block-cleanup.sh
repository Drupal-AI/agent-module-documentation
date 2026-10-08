#!/usr/bin/env bash
# Execution CLEANUP: same as reset - remove blocks.content and drop empty config. Exit 0.
set -uo pipefail
cd /var/www/html
bash "$(dirname "$0")/ultimenu-enable-block-reset.sh" >/dev/null 2>&1
echo "cleanup: ultimenu.settings blocks.content removed"
