#!/usr/bin/env bash
# Execution VERIFY: PASS when all three terms tcei_Red, tcei_Green, tcei_Blue exist in the 'tags'
# vocabulary. Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $ts = \Drupal::entityTypeManager()->getStorage("taxonomy_term");
  $found = 0;
  foreach (["tcei_Red","tcei_Green","tcei_Blue"] as $n) { if ($ts->loadByProperties(["name"=>$n,"vid"=>"tags"])) { $found++; } }
  $ok = ($found === 3);
  print ($ok ? "PASS" : "FAIL") . " found=" . $found . "/3\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
