#!/usr/bin/env bash
# Introspection SETUP: ensure a single Article 'node_class introspection target' exists with
# node_class = 'nc-known-42' so an inspecting agent can read the value back. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\Node;
  $t = "node_class introspection target";
  $ids = \Drupal::entityQuery("node")->condition("title", $t)->accessCheck(FALSE)->execute();
  foreach (Node::loadMultiple($ids) as $n) { $n->delete(); }
  Node::create(["type" => "article", "title" => $t, "node_class" => "nc-known-42", "status" => 1])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: Article 'node_class introspection target' has node_class=nc-known-42"
