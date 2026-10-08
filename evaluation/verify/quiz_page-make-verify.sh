#!/usr/bin/env bash
# Execution VERIFY: PASS when a quiz_question of type 'page' titled quiz_pg_task exists.
# Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $l = \Drupal::entityTypeManager()->getStorage("quiz_question")->loadByProperties(["type"=>"page","title"=>"quiz_pg_task"]);
  $q = $l ? reset($l) : NULL;
  $ok = ($q && $q->bundle() === "page");
  print ($ok ? "PASS" : "FAIL") . " exists=" . ($q?"1":"0") . " bundle=" . ($q?$q->bundle():"none") . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
