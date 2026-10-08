#!/usr/bin/env bash
# Introspection CLEANUP: delete the 'u404 medium draft' node(s).
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\Node;
  foreach (\Drupal::entityTypeManager()->getStorage("node")->loadByProperties(["title" => "u404 medium draft"]) as $n) { $n->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: 'u404 medium draft' removed"
