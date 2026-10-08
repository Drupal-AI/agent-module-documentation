#!/usr/bin/env bash
# Execution RESET (update_helper H2): remove the scratch CUD YAML the agent must write.
# Empty state => verify FAILS. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
rm -f "web/sites/default/update_helper_cud.eval.yml"
echo "reset: removed web/sites/default/update_helper_cud.eval.yml"
