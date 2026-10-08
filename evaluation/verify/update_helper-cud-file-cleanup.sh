#!/usr/bin/env bash
# Execution CLEANUP (update_helper H2): remove the scratch CUD YAML. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
rm -f "web/sites/default/update_helper_cud.eval.yml"
echo "cleanup: removed web/sites/default/update_helper_cud.eval.yml"
