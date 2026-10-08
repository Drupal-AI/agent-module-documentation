#!/usr/bin/env bash
# Execution RESET: ensure Article node 'VUA Task Node' exists with NO alias and NO mapping row,
# so verify FAILS until the agent gives it the alias. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\Node;
  $ids = \Drupal::entityQuery("node")->condition("title","VUA Task Node")->accessCheck(FALSE)->execute();
  if (!$ids) { $n = Node::create(["type"=>"article","title"=>"VUA Task Node"]); $n->save(); $id=$n->id(); }
  else { $id = reset($ids); }
  foreach (\Drupal::entityTypeManager()->getStorage("path_alias")->loadByProperties(["path"=>"/node/$id"]) as $pa) { $pa->delete(); }
  \Drupal::database()->delete("views_url_alias")->condition("entity_type","node")->condition("entity_id",$id)->execute();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: 'VUA Task Node' present, no alias, no views_url_alias row"
