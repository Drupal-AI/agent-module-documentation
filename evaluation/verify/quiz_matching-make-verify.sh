#!/usr/bin/env bash
# Execution VERIFY: PASS when a quiz_question of type matching titled quiz_mt_task exists with
# at least 2 quiz_matching pairs, each having a non-empty question and answer.
# Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $l = \Drupal::entityTypeManager()->getStorage("quiz_question")->loadByProperties(["type"=>"matching","title"=>"quiz_mt_task"]);
  $q = $l ? reset($l) : NULL;
  $n = 0; $valid = 0;
  if ($q) {
    foreach ($q->get("quiz_matching")->referencedEntities() as $p) {
      $n++;
      if (trim((string) $p->get("matching_question")->value) !== "" && trim((string) $p->get("matching_answer")->value) !== "") { $valid++; }
    }
  }
  $ok = ($q && $n >= 2 && $valid === $n);
  print ($ok ? "PASS" : "FAIL") . " exists=" . ($q?"1":"0") . " pairs=" . $n . " valid=" . $valid . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
