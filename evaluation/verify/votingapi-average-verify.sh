#!/usr/bin/env bash
# Live-state verification for the "eval_avg three votes 60/80/100, stored average ~80" task.
# Prints PASS/FAIL with detail and exits 0 (pass) / 1 (fail). No arguments.
# Two independent checks against the live site:
#   votes — at least three eval_avg `vote` entities exist on (node,1)
#   avg   — the stored eval_avg vote_average result for (node,1) is within 1.0 of 80
set -uo pipefail
cd /var/www/html

out=$(drush php:eval '
  $etm = \Drupal::entityTypeManager();

  // (1) At least three raw votes of type eval_avg on node 1.
  $vs = $etm->getStorage("vote");
  $votes = $vs->loadByProperties(["type" => "eval_avg", "entity_type" => "node", "entity_id" => 1]);
  $count = count($votes);
  $enough = ($count >= 3);

  // (2) A stored vote_average result for node 1 within tolerance of 80.
  $avg_ok = FALSE; $avg = "-";
  $rs = $etm->getStorage("vote_result");
  $results = $rs->loadByProperties(["type" => "eval_avg", "entity_type" => "node", "entity_id" => 1]);
  foreach ($results as $r) {
    if ($r->getFunction() === "vote_average") {
      $avg = (float) $r->getValue();
      if (abs($avg - 80.0) < 1.0) { $avg_ok = TRUE; }
    }
  }

  print (($enough && $avg_ok) ? "PASS" : "FAIL")
    . " votes=" . $count . " avg_ok=" . ($avg_ok ? 1 : 0) . " average=" . $avg . "\n";
' 2>/dev/null | grep -E "^(PASS|FAIL) ")

echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
