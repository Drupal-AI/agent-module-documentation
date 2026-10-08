#!/usr/bin/env bash
# Execution RESET: ensure an Article node "NK Task Node" exists with node_keeper=0 (unprotected)
# so verify FAILS until the agent protects it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\Node;
  $s = \Drupal::entityTypeManager()->getStorage("node");
  $nodes = $s->loadByProperties(["title" => "NK Task Node"]);
  $n = $nodes ? reset($nodes) : Node::create(["type" => "article", "title" => "NK Task Node"]);
  $n->set("node_keeper", FALSE);
  $n->save();
' >/dev/null 2>&1
echo "reset: Article 'NK Task Node' present, node_keeper=0"
