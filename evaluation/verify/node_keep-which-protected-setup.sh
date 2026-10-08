#!/usr/bin/env bash
# Introspection SETUP: create an Article node titled "NK Protected Probe" with node_keeper=1
# so an inspecting agent can find which node is deletion-protected. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\Node;
  $s = \Drupal::entityTypeManager()->getStorage("node");
  $nodes = $s->loadByProperties(["title" => "NK Protected Probe"]);
  $n = $nodes ? reset($nodes) : Node::create(["type" => "article", "title" => "NK Protected Probe"]);
  $n->set("node_keeper", TRUE);
  $n->save();
' >/dev/null 2>&1
echo "setup: Article 'NK Protected Probe' node_keeper=1"
