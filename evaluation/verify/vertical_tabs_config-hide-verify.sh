#!/usr/bin/env bash
# Execution VERIFY: PASS when the vertical_tabs_config table has a row hiding the 'options' tab on
# the Article content type (hidden=1). Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
n=$(drush sqlq "SELECT COUNT(*) FROM vertical_tabs_config WHERE content_type='article' AND vertical_tab='options' AND hidden=1;" 2>/dev/null | tr -d '[:space:]')
if [ "$n" = "1" ] || [ "$n" -ge 1 ] 2>/dev/null; then
  echo "PASS article/options hidden rows=$n"; exit 0
else
  echo "FAIL article/options hidden rows=${n:-0}"; exit 1
fi
