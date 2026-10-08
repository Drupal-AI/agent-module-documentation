#!/usr/bin/env bash
# Execution VERIFY: PASS when a redirect with source 'rm-task-src' exists AND redirect_metrics
# has initialised its access_count base field to 0 (not empty). Prints PASS/FAIL; exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\redirect\Entity\Redirect;
  $r = NULL;
  foreach (Redirect::loadMultiple() as $cand) {
    if ($cand->getSource()["path"] === "rm-task-src") { $r = $cand; break; }
  }
  if (!$r) { print "FAIL no-redirect\n"; }
  else {
    $has = $r->hasField("access_count");
    $empty = $r->get("access_count")->isEmpty();
    $val = $r->access_count->value;
    $ok = ($has && !$empty && (int) $val === 0);
    print ($ok ? "PASS" : "FAIL") . " has=" . var_export($has, TRUE) . " empty=" . var_export($empty, TRUE) . " count=" . var_export($val, TRUE) . "\n";
  }
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
