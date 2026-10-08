#!/usr/bin/env bash
# Execution CLEANUP: restore markdownify noindex=TRUE (shipped default). Idempotent.
set -uo pipefail
cd /var/www/html
drush cset markdownify.settings noindex 1 -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: markdownify.settings noindex=true (default restored)"
