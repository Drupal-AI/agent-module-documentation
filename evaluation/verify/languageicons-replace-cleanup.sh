#!/usr/bin/env bash
# Execution CLEANUP: restore shipped default placement (before). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush config:set languageicons.settings placement before -y >/dev/null 2>&1
echo "cleanup: languageicons.settings placement=before (default)"
