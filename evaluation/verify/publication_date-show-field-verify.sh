#!/usr/bin/env bash
# Live-state verification for the "show the publication date on the Article display" task.
# Prints PASS/FAIL and exits 0 (pass) / 1 (fail). No arguments.
# PASS when the node.article default view display renders the published_at field with a
# timestamp-style formatter (core registers published_at with 'timestamp' and 'timestamp_ago').
set -uo pipefail
cd /var/www/html

out=$(drush php:eval '
  $d = \Drupal::service("entity_display.repository")->getViewDisplay("node", "article", "default");
  $c = $d->getComponent("published_at");
  $type = ($c && isset($c["type"])) ? $c["type"] : "";
  $ok = ($type === "timestamp" || $type === "timestamp_ago");
  print ($ok ? "PASS" : "FAIL") . " type=" . ($type === "" ? "hidden" : $type) . "\n";
' 2>/dev/null)

echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
