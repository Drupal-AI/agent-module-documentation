#!/usr/bin/env bash
# Execution CLEANUP (update_helper H1): remove the scratch update-hook file. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
rm -f "web/sites/default/update_helper_hook.eval.php"
echo "cleanup: removed web/sites/default/update_helper_hook.eval.php"
