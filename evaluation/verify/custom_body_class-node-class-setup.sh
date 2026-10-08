#!/usr/bin/env bash
# Introspection SETUP: create an Article node with a KNOWN body_class field value so an
# agent can inspect the node and read it back. Removes any prior copy first.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\Node;
  $ids = \Drupal::entityQuery("node")->condition("title", "CBC Known Node")->accessCheck(FALSE)->execute();
  if ($ids) { foreach (Node::loadMultiple($ids) as $n) { $n->delete(); } }
  $node = Node::create(["type" => "article", "title" => "CBC Known Node", "body_class" => "cbc-known-class"]);
  $node->save();
' >/dev/null 2>&1
echo "setup: Article node CBC Known Node body_class=cbc-known-class"
