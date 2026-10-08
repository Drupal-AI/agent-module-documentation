#!/usr/bin/env bash
# Execution VERIFY: PASS when a quiz_question of type short_answer titled quiz_sa_task exists
# with short_answer_correct == "Rome" and short_answer_evaluation === 1 (case-insensitive auto).
# Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $l = \Drupal::entityTypeManager()->getStorage("quiz_question")->loadByProperties(["type"=>"short_answer","title"=>"quiz_sa_task"]);
  $q = $l ? reset($l) : NULL;
  $ans = $q ? (string) $q->get("short_answer_correct")->value : NULL;
  $ev = $q ? (string) $q->get("short_answer_evaluation")->value : NULL;
  $ok = ($q && $ans === "Rome" && $ev === "1");
  print ($ok ? "PASS" : "FAIL") . " exists=" . ($q?"1":"0") . " answer=" . var_export($ans, TRUE) . " eval=" . var_export($ev, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
