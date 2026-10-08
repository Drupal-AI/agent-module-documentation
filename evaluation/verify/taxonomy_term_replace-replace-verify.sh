#!/usr/bin/env bash
# Execution VERIFY: PASS when node TTR_TASK_NODE's field_ttr_tref now references the 'ttr_new' term
# (and no longer 'ttr_old'). exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $ts=\Drupal::entityTypeManager()->getStorage("taxonomy_term");
  $new=$ts->loadByProperties(["name"=>"ttr_new","vid"=>"ttr_task"]); $new=$new?reset($new):NULL;
  $old=$ts->loadByProperties(["name"=>"ttr_old","vid"=>"ttr_task"]); $old=$old?reset($old):NULL;
  $nodes=\Drupal::entityTypeManager()->getStorage("node")->loadByProperties(["title"=>"TTR_TASK_NODE"]);
  $node=$nodes?reset($nodes):NULL;
  $ids = $node ? array_column($node->get("field_ttr_tref")->getValue(),"target_id") : [];
  $ok = $new && $node && in_array($new->id(), $ids) && !in_array(($old?$old->id():-1), $ids);
  print ($ok ? "PASS" : "FAIL") . " refs=" . implode(",", $ids) . " new=" . ($new?$new->id():"?") . " old=" . ($old?$old->id():"?") . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
