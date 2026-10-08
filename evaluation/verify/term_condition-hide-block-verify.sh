#!/usr/bin/env bash
# Execution VERIFY: PASS when block tc_task_block_h2 has a NEGATED Term condition whose
# term_uuids contains the UUID of term "TC Task Term B". Prints PASS/FAIL. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\block\Entity\Block;
  $found = \Drupal::entityTypeManager()->getStorage("taxonomy_term")->loadByProperties(["name"=>"TC Task Term B","vid"=>"tc_eval_h2"]);
  $term = $found ? reset($found) : NULL;
  $uuid = $term ? $term->uuid() : "NO_TERM";
  $b = Block::load("tc_task_block_h2");
  $v = $b ? $b->getVisibility() : [];
  $cond = $v["term"] ?? NULL;
  $uuids = $cond["term_uuids"] ?? [];
  $negate = $cond["negate"] ?? NULL;
  $ok = ($cond && in_array($uuid, $uuids, TRUE) && $negate == TRUE);
  print ($ok ? "PASS" : "FAIL") . " has_cond=" . ($cond ? "y" : "n") . " match=" . (in_array($uuid,$uuids,TRUE)?"y":"n") . " negate=" . var_export($negate, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
