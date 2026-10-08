#!/usr/bin/env bash
# Execution VERIFY: PASS when an Article titled 'ERT Auto Node' exists and its field_ert_auto
# read-time was auto-populated (minutes>0 or seconds>0). exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $ids = \Drupal::entityTypeManager()->getStorage("node")->getQuery()->accessCheck(FALSE)->condition("title", "ERT Auto Node")->execute();
  $n = $ids ? \Drupal::entityTypeManager()->getStorage("node")->load(reset($ids)) : NULL;
  $min = $n ? (int) $n->get("field_ert_auto")->minutes : 0;
  $sec = $n ? (int) $n->get("field_ert_auto")->seconds : 0;
  $ok = $n && ($min > 0 || $sec > 0);
  print ($ok ? "PASS" : "FAIL") . " node=" . ($n ? "yes" : "no") . " minutes=" . $min . " seconds=" . $sec . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
