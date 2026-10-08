#!/usr/bin/env bash
# Live-state verification for the "make the scheduled publish date required on Article" task.
# Prints PASS/FAIL with detail and exits 0 (pass) / 1 (fail). No arguments.
# Single check:
#   cfg  — node.type.article has scheduler publish_required TRUE (the date field is mandatory)
set -uo pipefail
cd /var/www/html

out=$(drush php:eval '
  $req = FALSE;
  if ($type = \Drupal\node\Entity\NodeType::load("article")) {
    $req = (bool) $type->getThirdPartySetting("scheduler", "publish_required");
  }
  print ($req ? "PASS" : "FAIL") . " publish_required=" . ($req?1:0) . "\n";
' 2>/dev/null)

echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
