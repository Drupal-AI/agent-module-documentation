#!/usr/bin/env bash
# Execution VERIFY: PASS when the node titled "CB Hard One" now has bundle convbnd_to.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $ns = \Drupal::entityTypeManager()->getStorage("node")->loadByProperties(["title" => "CB Hard One"]);
  $n = $ns ? reset($ns) : NULL;
  $b = $n ? $n->bundle() : "none";
  print (($b === "convbnd_to") ? "PASS" : "FAIL") . " bundle=" . $b . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
