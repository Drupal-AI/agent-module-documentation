#!/usr/bin/env bash
# Execution RESET (entity_reference_override H2): remove the scratch formatter-config snippet the
# agent must write. Empty state => verify FAILS. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
rm -f "web/sites/default/entity_reference_override_formatter.eval.php"
echo "reset: removed web/sites/default/entity_reference_override_formatter.eval.php"
