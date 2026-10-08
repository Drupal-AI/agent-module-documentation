#!/usr/bin/env bash
# Execution RESET (entity_reference_override_entity_browser H1): remove the scratch snippet the
# agent must write. Empty state => verify FAILS. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
rm -f "web/sites/default/entity_reference_override_entity_browser_widget.eval.php"
echo "reset: removed web/sites/default/entity_reference_override_entity_browser_widget.eval.php"
