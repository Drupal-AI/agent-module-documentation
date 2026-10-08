#!/usr/bin/env bash
# Execution CLEANUP: delete the 'U404 Hard Draft' node(s).
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\Node;
  foreach (\Drupal::entityTypeManager()->getStorage("node")->loadByProperties(["title" => "U404 Hard Draft"]) as $n) { $n->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: 'U404 Hard Draft' removed"
