#!/usr/bin/env bash
# Execution CLEANUP: ensure the progressive-rebuild state is clean (as after finished()). Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::state()->set("node_access_rebuild_progressive.current", 0);
  \Drupal::state()->delete("node_access_rebuild_progressive.bundles");
  \Drupal::state()->delete("node_access_rebuild_progressive.processed");
' >/dev/null 2>&1
echo "cleanup: state cleared (current=0, bundles/processed deleted)"
