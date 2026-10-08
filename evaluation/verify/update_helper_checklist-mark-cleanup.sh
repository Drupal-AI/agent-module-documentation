#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
rm -f "web/sites/default/update_helper_checklist_mark.eval.php"
echo "cleanup: removed web/sites/default/update_helper_checklist_mark.eval.php"
