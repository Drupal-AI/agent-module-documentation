#!/usr/bin/env bash
# Live-state verification for "record a view for the node 'Statistics Hard Record Target' via
# the Statistics storage service". Prints PASS/FAIL and exits 0 (pass) / 1 (fail). No arguments.
# Finds the node by title, reads its count through the statistics.storage.node service, and
# passes iff a counter row exists with totalcount >= 1.
set -uo pipefail
cd /var/www/html

out=$(drush php:eval '
  $found = FALSE; $total = 0; $detail = "no-node";
  $nodes = \Drupal::entityTypeManager()->getStorage("node")
    ->loadByProperties(["title" => "Statistics Hard Record Target"]);
  if ($nodes) {
    $node = reset($nodes);
    $view = \Drupal::service("statistics.storage.node")->fetchView($node->id());
    $total = $view ? (int) $view->getTotalCount() : 0;
    $found = $view && $total >= 1;
    $detail = "nid=" . $node->id() . " totalcount=" . $total;
  }
  print ($found ? "PASS" : "FAIL") . " " . $detail . "\n";
' 2>/dev/null)

echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
