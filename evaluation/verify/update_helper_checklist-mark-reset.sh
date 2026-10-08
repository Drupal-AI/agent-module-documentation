#!/usr/bin/env bash
# Execution RESET (update_helper_checklist H2): remove the scratch marking-snippet the agent must
# write. Empty state => verify FAILS. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
rm -f "web/sites/default/update_helper_checklist_mark.eval.php"
echo "reset: removed web/sites/default/update_helper_checklist_mark.eval.php"
