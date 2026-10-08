#!/usr/bin/env bash
# Execution CLEANUP: remove field_ld_task from Article. Restores baseline.
set -uo pipefail
cd /var/www/html
bash "$(dirname "$0")/link_description-add-field-reset.sh" >/dev/null 2>&1
echo "cleanup: field_ld_task removed from node.article"
