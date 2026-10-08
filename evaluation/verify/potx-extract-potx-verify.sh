#!/usr/bin/env bash
# Execution VERIFY: PASS when a general.pot was generated in the Drupal docroot and contains
# potx's own translatable string "Template language" (proving real extraction of the potx module).
# Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
ROOT=$(drush php:eval 'echo DRUPAL_ROOT;' 2>/dev/null)
[ -n "$ROOT" ] || ROOT=/var/www/html/web
POT="$ROOT/general.pot"
if [ -s "$POT" ] && grep -q '^msgid "Template language"' "$POT"; then
  echo "PASS $POT has potx strings (msgid \"Template language\")"
  exit 0
fi
echo "FAIL $POT missing or does not contain potx's 'Template language' string"
exit 1
