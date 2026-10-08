#!/usr/bin/env bash
# Execution RESET: simulate an interrupted rebuild by seeding leftover state
# (.current non-zero, .bundles set) so verify (clean state) FAILS. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::state()->set("node_access_rebuild_progressive.current", 987654);
  \Drupal::state()->set("node_access_rebuild_progressive.processed", 42);
  \Drupal::state()->set("node_access_rebuild_progressive.bundles", ["article"]);
' >/dev/null 2>&1
echo "reset: current=987654 processed=42 bundles=[article] (simulated interrupted rebuild)"
