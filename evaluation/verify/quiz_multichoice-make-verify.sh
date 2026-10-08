#!/usr/bin/env bash
# Execution VERIFY: PASS when a quiz_question of type multichoice titled quiz_mc_task exists
# with at least 2 alternatives and exactly one marked correct (multichoice_correct=1).
# Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $l = \Drupal::entityTypeManager()->getStorage("quiz_question")->loadByProperties(["type"=>"multichoice","title"=>"quiz_mc_task"]);
  $q = $l ? reset($l) : NULL;
  $n = 0; $correct = 0;
  if ($q) {
    foreach ($q->get("alternatives")->referencedEntities() as $p) {
      $n++;
      if ((string) $p->get("multichoice_correct")->value === "1") { $correct++; }
    }
  }
  $ok = ($q && $n >= 2 && $correct === 1);
  print ($ok ? "PASS" : "FAIL") . " exists=" . ($q?"1":"0") . " alternatives=" . $n . " correct=" . $correct . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
