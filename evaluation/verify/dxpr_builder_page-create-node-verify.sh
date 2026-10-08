#!/usr/bin/env bash
# Execution VERIFY: PASS when at least one node of type drag_and_drop_page exists (the content
# type provided by dxpr_builder_page). Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $ids = \Drupal::entityQuery("node")->condition("type", "drag_and_drop_page")->accessCheck(FALSE)->execute();
  $n = count($ids);
  print ($n > 0 ? "PASS" : "FAIL") . " drag_and_drop_page_nodes=" . $n . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
