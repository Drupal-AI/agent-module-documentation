#!/usr/bin/env bash
# Execution RESET: force markdownify noindex=TRUE (Markdown responses NOT indexable) so verify
# FAILS until the agent makes them indexable. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush cset markdownify.settings noindex 1 -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: markdownify.settings noindex=true"
