#!/usr/bin/env bash
# Execution VERIFY: PASS when a quiz_question of type long_answer titled quiz_la_task exists
# with a non-empty long_answer_rubric. Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $l = \Drupal::entityTypeManager()->getStorage("quiz_question")->loadByProperties(["type"=>"long_answer","title"=>"quiz_la_task"]);
  $q = $l ? reset($l) : NULL;
  $rubric = $q ? trim((string) $q->get("long_answer_rubric")->value) : "";
  $ok = ($q && $rubric !== "");
  print ($ok ? "PASS" : "FAIL") . " exists=" . ($q?"1":"0") . " rubric_len=" . strlen($rubric) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
