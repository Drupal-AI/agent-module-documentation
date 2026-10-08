#!/usr/bin/env bash
# Introspection SETUP: create an Article node titled sna_known_node with a known extra URL
# alias (/sna-known-alias) so an inspecting agent can read back the node's aliases. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\Node;
  use Drupal\path_alias\Entity\PathAlias;
  $ids = \Drupal::entityTypeManager()->getStorage("node")->getQuery()
    ->accessCheck(FALSE)->condition("title", "sna_known_node")->execute();
  if ($ids) { $nid = reset($ids); }
  else {
    $n = Node::create(["type" => "article", "title" => "sna_known_node"]); $n->save(); $nid = $n->id();
  }
  $existing = \Drupal::entityTypeManager()->getStorage("path_alias")->loadByProperties([
    "path" => "/node/" . $nid, "alias" => "/sna-known-alias",
  ]);
  if (!$existing) {
    PathAlias::create(["path" => "/node/" . $nid, "alias" => "/sna-known-alias", "langcode" => "en"])->save();
  }
  print "nid=" . $nid . "\n";
' 2>/dev/null
drush cr >/dev/null 2>&1
echo "setup: node sna_known_node has alias /sna-known-alias"
