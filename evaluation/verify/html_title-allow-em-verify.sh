#!/usr/bin/env bash
# Execution VERIFY: PASS when the html_title allowlist now permits the <em> tag.
# Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
val=$(drush config:get html_title.settings allow_html_tags --format=string 2>/dev/null)
if echo "$val" | grep -q '<em>'; then
  echo "PASS allow_html_tags=$val"
  exit 0
else
  echo "FAIL allow_html_tags=$val"
  exit 1
fi
