#!/usr/bin/env bash
# Execution VERIFY (error_page H1): PASS when the snippet file registers error_page's fatal
# error + exception handlers (set_error_handler + set_exception_handler pointing at
# Drupal\error_page\ErrorPageErrorHandler). Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
f="web/sites/default/settings.error_page_handlers.eval.php"
if [ -f "$f" ] && grep -q 'set_error_handler' "$f" && grep -q 'set_exception_handler' "$f" && grep -q 'ErrorPageErrorHandler' "$f"; then
  echo "PASS: $f registers ErrorPageErrorHandler via set_error_handler + set_exception_handler"
  exit 0
fi
echo "FAIL: $f missing or does not register both handlers for ErrorPageErrorHandler"
exit 1
