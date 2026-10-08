#!/usr/bin/env bash
# Execution CLEANUP (error_page H1): remove the scratch settings snippet the agent must write.
# error_page is configured only in PHP settings; to keep the SHARED site's real settings.php
# untouched, the target is a dedicated deletable snippet file. Empty state => verify FAILS.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
rm -f "web/sites/default/settings.error_page_handlers.eval.php"
echo "cleanup: removed web/sites/default/settings.error_page_handlers.eval.php"
