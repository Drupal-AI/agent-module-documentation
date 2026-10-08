#!/usr/bin/env bash
# Execution RESET: remove every formblock_node block instance from the site so that verify
# FAILS on empty state. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $n = 0;
  foreach (\Drupal::entityTypeManager()->getStorage("block")->loadMultiple() as $b) {
    if ($b->getPluginId() === "formblock_node") { $b->delete(); $n++; }
  }
  print "removed=$n\n";
' 2>/dev/null
echo "reset: no formblock_node block instances remain"
