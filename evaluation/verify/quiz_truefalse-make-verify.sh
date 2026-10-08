#!/usr/bin/env bash
# Execution VERIFY: PASS when a quiz_question of type truefalse titled quiz_tf_task exists with
# truefalse_correct === 0 (correct answer False). Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $l = \Drupal::entityTypeManager()->getStorage("quiz_question")->loadByProperties(["type"=>"truefalse","title"=>"quiz_tf_task"]);
  $q = $l ? reset($l) : NULL;
  $c = $q ? $q->get("truefalse_correct")->value : NULL;
  $ok = ($q && (string) $c === "0");
  print ($ok ? "PASS" : "FAIL") . " exists=" . ($q?"1":"0") . " truefalse_correct=" . var_export($c, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
