#!/usr/bin/env bash
# Live-state verification for the "cast an eval_rating vote of 80 on node 1 and aggregate"
# Voting API task. Prints PASS/FAIL with detail and exits 0 (pass) / 1 (fail). No arguments.
# Two independent checks against the live site:
#   vote — at least one `vote` content entity on (node, 1) has value ~80 (float tolerance)
#   res  — a `vote_result` content entity exists for (node, 1) with a sane summary value
set -uo pipefail
cd /var/www/html

out=$(drush php:eval '
  $etm = \Drupal::entityTypeManager();

  // (1) A raw vote of value 80 on node 1.
  $vote = FALSE; $val = "-";
  $vs = $etm->getStorage("vote");
  $votes = $vs->loadByProperties(["entity_type" => "node", "entity_id" => 1]);
  foreach ($votes as $v) {
    $vv = (float) $v->getValue();
    if (abs($vv - 80.0) < 0.5) { $vote = TRUE; $val = $vv; break; }
  }

  // (2) An aggregate result row for node 1 with a sane numeric value.
  $res = FALSE; $fn = "-"; $rval = "-";
  $rs = $etm->getStorage("vote_result");
  $results = $rs->loadByProperties(["entity_type" => "node", "entity_id" => 1]);
  foreach ($results as $r) {
    $rv = (float) $r->getValue();
    if (is_finite($rv) && $rv >= 0) { $res = TRUE; $fn = $r->getFunction(); $rval = $rv; break; }
  }

  print (($vote && $res) ? "PASS" : "FAIL")
    . " vote=" . ($vote ? 1 : 0) . " value=" . $val
    . " result=" . ($res ? 1 : 0) . " fn=" . $fn . " rval=" . $rval . "\n";
' 2>/dev/null | grep -E "^(PASS|FAIL) ")

echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
