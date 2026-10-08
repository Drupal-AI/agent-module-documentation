#!/usr/bin/env bash
# Execution VERIFY: PASS when a non-empty general.pot with at least one msgid entry was generated
# in the Drupal docroot (from extracting the locale module). Prints PASS/FAIL; exit 0/1.
set -uo pipefail
cd /var/www/html
ROOT=$(drush php:eval 'echo DRUPAL_ROOT;' 2>/dev/null)
[ -n "$ROOT" ] || ROOT=/var/www/html/web
POT="$ROOT/general.pot"
count=0
[ -f "$POT" ] && count=$(grep -c '^msgid "' "$POT" 2>/dev/null || echo 0)
if [ -s "$POT" ] && [ "$count" -ge 2 ]; then
  echo "PASS $POT generated with $count msgid entries (header + real strings)"
  exit 0
fi
echo "FAIL $POT missing or has no extracted strings (count=$count, need >=2)"
exit 1
