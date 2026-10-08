#!/usr/bin/env bash
# Execution VERIFY: PASS when routecond_excl has a Route condition line that EXCLUDES the
# user login route, i.e. a line "~user.login" (tilde prefix). Exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\block\Entity\Block;
  $b = Block::load("routecond_excl");
  $routes = $b ? ($b->getVisibility()["route"]["routes"] ?? "") : "";
  $lines = array_filter(array_map("trim", preg_split("/\r\n|\r|\n/", strtolower($routes))));
  $ok = in_array("~user.login", $lines, TRUE);
  print ($ok ? "PASS" : "FAIL") . " routes=" . json_encode($routes) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
