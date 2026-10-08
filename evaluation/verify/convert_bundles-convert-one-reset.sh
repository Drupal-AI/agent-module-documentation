#!/usr/bin/env bash
# Execution RESET for "convert one node from convbnd_from to convbnd_to".
# Ensures the two namespaced content types exist, deletes any prior test node, and creates a
# single node "CB Hard One" of type convbnd_from. Verify FAILS until its bundle == convbnd_to.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\NodeType;
  use Drupal\node\Entity\Node;
  foreach (["convbnd_from" => "CB From", "convbnd_to" => "CB To"] as $id => $name) {
    if (!NodeType::load($id)) { NodeType::create(["type" => $id, "name" => $name])->save(); }
  }
  foreach (\Drupal::entityTypeManager()->getStorage("node")->loadByProperties(["title" => "CB Hard One"]) as $n) { $n->delete(); }
  Node::create(["type" => "convbnd_from", "title" => "CB Hard One"])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: node \"CB Hard One\" created as convbnd_from (target convbnd_to)"
