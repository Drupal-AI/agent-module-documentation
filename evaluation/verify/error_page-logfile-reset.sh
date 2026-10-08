#!/usr/bin/env bash
# Execution RESET (error_page H2): remove the scratch settings snippet (keeps the shared
# settings.php untouched). Empty state => verify FAILS. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
rm -f "web/sites/default/settings.error_page_log.eval.php"
echo "reset: removed web/sites/default/settings.error_page_log.eval.php"
