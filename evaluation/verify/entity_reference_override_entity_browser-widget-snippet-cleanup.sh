#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
rm -f "web/sites/default/entity_reference_override_entity_browser_widget.eval.php"
echo "cleanup: removed web/sites/default/entity_reference_override_entity_browser_widget.eval.php"
