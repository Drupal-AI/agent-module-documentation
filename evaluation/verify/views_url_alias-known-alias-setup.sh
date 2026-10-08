#!/usr/bin/env bash
# Introspection SETUP: create an Article node with a known URL alias so the module's sync hook
# inserts a row into the views_url_alias mapping table for an agent to read back. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\Node;
  use Drupal\path_alias\Entity\PathAlias;
  $ids = \Drupal::entityQuery("node")->condition("title","VUA Known City")->accessCheck(FALSE)->execute();
  if (!$ids) { $n = Node::create(["type"=>"article","title"=>"VUA Known City"]); $n->save(); $id=$n->id(); }
  else { $id = reset($ids); }
  $ex = \Drupal::entityTypeManager()->getStorage("path_alias")->loadByProperties(["path"=>"/node/$id"]);
  if (!$ex) { PathAlias::create(["path"=>"/node/$id","alias"=>"/vua-known-city"])->save(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: node 'VUA Known City' aliased /vua-known-city; row in views_url_alias"
