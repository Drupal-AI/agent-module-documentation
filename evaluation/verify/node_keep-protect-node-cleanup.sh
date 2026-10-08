#!/usr/bin/env bash
# Execution CLEANUP: delete the "NK Task Node" node to leave the site clean. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $s = \Drupal::entityTypeManager()->getStorage("node");
  foreach ($s->loadByProperties(["title" => "NK Task Node"]) as $n) { $n->delete(); }
' >/dev/null 2>&1
echo "cleanup: 'NK Task Node' removed"
