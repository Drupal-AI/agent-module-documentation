#!/usr/bin/env bash
# Execution VERIFY (error_page H2): PASS when the snippet enables error_page's PHP-file error
# logging: $settings['error_page']['log']['method'] = 3 plus a destination. Accepts single or
# double quotes around the array keys. exit 0/1.
set -uo pipefail
cd /var/www/html
f="web/sites/default/settings.error_page_log.eval.php"
if [ -f "$f" ] \
  && grep -q "error_page" "$f" \
  && grep -Eq "method[\"']\][[:space:]]*=[[:space:]]*3" "$f" \
  && grep -q "destination" "$f"; then
  echo "PASS: $f sets error_page log method=3 with a destination"
  exit 0
fi
echo "FAIL: $f missing or does not set error_page log method=3 + destination"
exit 1
