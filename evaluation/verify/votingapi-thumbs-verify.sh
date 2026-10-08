#!/usr/bin/env bash
# Live-state verification for the "eval_thumbs thumbs-up" Voting API task.
# Prints PASS/FAIL with detail and exits 0 (pass) / 1 (fail). No arguments.
# Three independent checks against the live site:
#   vt   — an eval_thumbs vote_type config entity exists with value type "points"
#   vote — an eval_thumbs `vote` on (node,1) has value +1 and was cast anonymously (uid 0)
#   res  — an eval_thumbs `vote_result` aggregate for (node,1) exists
set -uo pipefail
cd /var/www/html

out=$(drush php:eval '
  $etm = \Drupal::entityTypeManager();

  // (1) vote_type eval_thumbs of value type points.
  $vt = FALSE; $vtval = "-";
  if ($t = $etm->getStorage("vote_type")->load("eval_thumbs")) {
    $vtval = $t->getValueType();
    if ($vtval === "points") { $vt = TRUE; }
  }

  // (2) An anonymous +1 vote on node 1 of type eval_thumbs.
  $vote = FALSE; $val = "-";
  $vs = $etm->getStorage("vote");
  $votes = $vs->loadByProperties(["type" => "eval_thumbs", "entity_type" => "node", "entity_id" => 1]);
  foreach ($votes as $v) {
    $vv = (float) $v->getValue();
    if (abs($vv - 1.0) < 0.01 && (int) $v->getOwnerId() === 0) { $vote = TRUE; $val = $vv; break; }
  }

  // (3) An aggregate result row for node 1 of type eval_thumbs.
  $res = FALSE; $fn = "-"; $rval = "-";
  $rs = $etm->getStorage("vote_result");
  $results = $rs->loadByProperties(["type" => "eval_thumbs", "entity_type" => "node", "entity_id" => 1]);
  foreach ($results as $r) {
    $rv = (float) $r->getValue();
    if (is_finite($rv)) { $res = TRUE; $fn = $r->getFunction(); $rval = $rv; break; }
  }

  print (($vt && $vote && $res) ? "PASS" : "FAIL")
    . " vt=" . ($vt ? 1 : 0) . " value_type=" . $vtval
    . " vote=" . ($vote ? 1 : 0) . " value=" . $val
    . " result=" . ($res ? 1 : 0) . " fn=" . $fn . " rval=" . $rval . "\n";
' 2>/dev/null | grep -E "^(PASS|FAIL) ")

echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
