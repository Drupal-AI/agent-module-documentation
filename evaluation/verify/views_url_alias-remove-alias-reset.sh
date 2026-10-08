#!/usr/bin/env bash
# Execution RESET: ensure Article node 'VUA Del Node' exists WITH alias /vua-del-path and a
# mapping row present, so verify FAILS (row still there) until the agent removes the alias.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\Node;
  use Drupal\path_alias\Entity\PathAlias;
  $ids = \Drupal::entityQuery("node")->condition("title","VUA Del Node")->accessCheck(FALSE)->execute();
  if (!$ids) { $n = Node::create(["type"=>"article","title"=>"VUA Del Node"]); $n->save(); $id=$n->id(); }
  else { $id = reset($ids); }
  $ex = \Drupal::entityTypeManager()->getStorage("path_alias")->loadByProperties(["path"=>"/node/$id"]);
  if (!$ex) { PathAlias::create(["path"=>"/node/$id","alias"=>"/vua-del-path"])->save(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: 'VUA Del Node' aliased /vua-del-path with mapping row present"
