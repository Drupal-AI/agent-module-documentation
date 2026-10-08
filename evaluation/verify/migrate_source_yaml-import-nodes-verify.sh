#!/usr/bin/env bash
# Execution VERIFY: PASS when two Article nodes titled 'MSY Alpha' and 'MSY Beta' exist on the
# live site (imported via a yaml-source migration). Prints PASS/FAIL; exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $found = [];
  foreach (["MSY Alpha", "MSY Beta"] as $t) {
    $ids = \Drupal::entityQuery("node")->accessCheck(FALSE)->condition("type", "article")->condition("title", $t)->execute();
    if ($ids) { $found[] = $t; }
  }
  $ok = (count($found) === 2);
  print ($ok ? "PASS" : "FAIL") . " found=" . implode("|", $found) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
