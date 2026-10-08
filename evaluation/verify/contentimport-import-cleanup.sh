#!/usr/bin/env bash
# Execution CLEANUP (contentimport): delete the two imported Article nodes. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $st = \Drupal::entityTypeManager()->getStorage("node");
  foreach (["CI Import Alpha", "CI Import Beta"] as $t) {
    foreach ($st->loadByProperties(["type" => "article", "title" => $t]) as $n) { $n->delete(); }
  }
' >/dev/null 2>&1
echo "cleanup: removed imported Article nodes 'CI Import Alpha' / 'CI Import Beta'"
