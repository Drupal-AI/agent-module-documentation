#!/usr/bin/env bash
# Execution CLEANUP: delete the "NK Alias Node" node. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $s = \Drupal::entityTypeManager()->getStorage("node");
  foreach ($s->loadByProperties(["title" => "NK Alias Node"]) as $n) { $n->delete(); }
' >/dev/null 2>&1
echo "cleanup: 'NK Alias Node' removed"
