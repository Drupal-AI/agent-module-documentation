#!/usr/bin/env bash
# Execution VERIFY: PASS when a quiz entity titled quiz_task exists with pass_rate 80 and
# unlimited attempts (takes 0). Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $l = \Drupal::entityTypeManager()->getStorage("quiz")->loadByProperties(["title"=>"quiz_task"]);
  $q = $l ? reset($l) : NULL;
  $pr = $q ? (int) $q->get("pass_rate")->value : -1;
  $tk = $q ? (int) $q->get("takes")->value : -1;
  $ok = ($q && $pr === 80 && $tk === 0);
  print ($ok ? "PASS" : "FAIL") . " exists=" . ($q?"1":"0") . " pass_rate=" . $pr . " takes=" . $tk . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
