#!/usr/bin/env bash
# Execution RESET (update_helper_checklist H1): remove the scratch updates_checklist file the
# agent must write. Empty state => verify FAILS. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
rm -f "web/sites/default/update_helper_checklist_file.eval.yml"
echo "reset: removed web/sites/default/update_helper_checklist_file.eval.yml"
