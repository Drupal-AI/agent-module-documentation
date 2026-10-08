#!/usr/bin/env bash
# Execution RESET (update_helper H1): remove the scratch update-hook file the agent must write.
# Empty state => verify FAILS. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
rm -f "web/sites/default/update_helper_hook.eval.php"
echo "reset: removed web/sites/default/update_helper_hook.eval.php"
