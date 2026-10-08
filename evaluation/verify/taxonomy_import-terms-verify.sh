#!/usr/bin/env bash
# Execution VERIFY: PASS when the ti_task vocabulary contains terms named Red, Green and Blue.
# exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $storage = \Drupal::entityTypeManager()->getStorage("taxonomy_term");
  $have = [];
  foreach ($storage->loadByProperties(["vid" => "ti_task"]) as $t) { $have[$t->label()] = TRUE; }
  $want = ["Red", "Green", "Blue"];
  $missing = array_diff($want, array_keys($have));
  print (empty($missing) ? "PASS" : "FAIL") . " terms=" . implode(",", array_keys($have)) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
