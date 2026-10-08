#!/usr/bin/env bash
# Execution VERIFY: PASS when routecond_task has a Route condition whose routes include the
# node canonical route name (entity.node.canonical), matched either exactly or via a wildcard
# like entity.node.* or entity.*.canonical. Exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\block\Entity\Block;
  $b = Block::load("routecond_task");
  $routes = $b ? ($b->getVisibility()["route"]["routes"] ?? "") : "";
  $lines = array_filter(array_map("trim", preg_split("/\r\n|\r|\n/", strtolower($routes))));
  $ok = FALSE;
  foreach ($lines as $l) {
    if ($l[0] === "~") { continue; }
    if ($l === "entity.node.canonical") { $ok = TRUE; break; }
    if (strpos($l, "*") !== FALSE) {
      $re = "{^" . str_replace("*", ".*", str_replace(".", "\\.", $l)) . "$}";
      if (preg_match($re, "entity.node.canonical")) { $ok = TRUE; break; }
    }
  }
  print ($ok ? "PASS" : "FAIL") . " routes=" . json_encode($routes) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
