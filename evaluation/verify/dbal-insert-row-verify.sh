#!/usr/bin/env bash
# Execution VERIFY: PASS when table dbal_task2 contains a row whose note = 'dbal-done'.
# exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush sql:query "SELECT note FROM dbal_task2 WHERE note = 'dbal-done'" 2>/dev/null)
if echo "$out" | grep -q 'dbal-done'; then
  echo "PASS dbal_task2 has note=dbal-done"; exit 0
else
  echo "FAIL dbal_task2 has no note=dbal-done (got: $out)"; exit 1
fi
