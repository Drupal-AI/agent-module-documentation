#!/usr/bin/env bash
# Execution VERIFY: PASS when a merge rule exists so that saving a NEW term named "kitten" in
# vocabulary tmm_task is auto-rewritten into the existing "Cats" target term. Proves the rule by
# actually creating "kitten" and checking it became "Cats" (same tid as target). If not merged,
# the stray "kitten" term is deleted to keep the site clean. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\taxonomy\Entity\Term;
  $t = \Drupal::entityQuery("taxonomy_term")->condition("vid","tmm_task")->condition("name","Cats")->accessCheck(FALSE)->execute();
  if (!$t) { print "FAIL no-target\n"; return; }
  $targetTid = (int) reset($t);
  $k = Term::create(["vid"=>"tmm_task","name"=>"kitten"]); $k->save();
  $merged = ($k->getName() === "Cats" && (int) $k->id() === $targetTid);
  if (!$merged) { $k->delete(); }
  print ($merged ? "PASS" : "FAIL") . " name=" . $k->getName() . " tid=" . $k->id() . " target=" . $targetTid . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
