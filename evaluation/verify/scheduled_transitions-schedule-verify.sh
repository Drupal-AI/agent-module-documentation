#!/usr/bin/env bash
# Execution VERIFY: PASS when a scheduled_transition entity targets node "ST Sched One" with
# moderation_state 'archived' and is not yet processed.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $ns = \Drupal::entityTypeManager()->getStorage("node")->loadByProperties(["title"=>"ST Sched One"]);
  $n = $ns ? reset($ns) : NULL;
  if (!$n) { print "FAIL no-node\n"; return; }
  $ids = \Drupal::entityTypeManager()->getStorage("scheduled_transition")->getQuery()->accessCheck(FALSE)
    ->condition("entity__target_type","node")->condition("entity__target_id",$n->id())
    ->condition("moderation_state","archived")->condition("is_processed","1","<>")->execute();
  print ((count($ids) > 0) ? "PASS" : "FAIL")." transitions=".count($ids)."\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
