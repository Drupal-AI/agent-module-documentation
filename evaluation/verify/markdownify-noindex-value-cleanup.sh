#!/usr/bin/env bash
# Introspection CLEANUP: restore markdownify noindex to shipped default TRUE. Idempotent.
set -uo pipefail
cd /var/www/html
drush cset markdownify.settings noindex 1 -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: markdownify.settings noindex=true (default restored)"
