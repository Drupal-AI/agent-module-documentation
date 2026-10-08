#!/usr/bin/env bash
# Execution VERIFY: PASS when file_url.settings dereference_host is set to the expected
# canonical host https://files.example.com (non-empty, exact). exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
val=$(drush cget file_url.settings dereference_host --format=string 2>/dev/null)
echo "dereference_host=[$val]"
[ "$val" = "https://files.example.com" ] && { echo PASS; exit 0; } || { echo FAIL; exit 1; }
