#!/usr/bin/env bash
# Execution RESET (contentimport): delete any Article nodes titled 'CI Import Alpha' or
# 'CI Import Beta', so verify FAILS until the agent imports them. Only touches those two titles.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $st = \Drupal::entityTypeManager()->getStorage("node");
  foreach (["CI Import Alpha", "CI Import Beta"] as $t) {
    foreach ($st->loadByProperties(["type" => "article", "title" => $t]) as $n) { $n->delete(); }
  }
' >/dev/null 2>&1
echo "reset: removed Article nodes titled 'CI Import Alpha' / 'CI Import Beta'"
