#!/usr/bin/env bash
# Execution CLEANUP: remove the test node and the two namespaced content types.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\NodeType;
  foreach (\Drupal::entityTypeManager()->getStorage("node")->loadByProperties(["title" => "CB Hard One"]) as $n) { $n->delete(); }
  foreach (["convbnd_from", "convbnd_to"] as $id) { if ($t = NodeType::load($id)) { $t->delete(); } }
' >/dev/null 2>&1
echo "cleanup: CB Hard One node + convbnd_from/convbnd_to removed"
