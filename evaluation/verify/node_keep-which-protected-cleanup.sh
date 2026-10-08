#!/usr/bin/env bash
# Introspection CLEANUP: delete the "NK Protected Probe" node. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $s = \Drupal::entityTypeManager()->getStorage("node");
  foreach ($s->loadByProperties(["title" => "NK Protected Probe"]) as $n) { $n->delete(); }
' >/dev/null 2>&1
echo "cleanup: 'NK Protected Probe' removed"
