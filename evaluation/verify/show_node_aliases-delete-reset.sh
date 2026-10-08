#!/usr/bin/env bash
# Execution RESET: node sna_del_node with an existing alias /sna-old-alias, so verify (passes
# only when that alias is gone) FAILS until the agent deletes it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\Node;
  use Drupal\path_alias\Entity\PathAlias;
  $ids=\Drupal::entityTypeManager()->getStorage("node")->getQuery()->accessCheck(FALSE)->condition("title","sna_del_node")->execute();
  foreach ($ids as $nid){
    foreach (\Drupal::entityTypeManager()->getStorage("path_alias")->loadByProperties(["path"=>"/node/".$nid]) as $pa){$pa->delete();}
    if ($n=Node::load($nid)){$n->delete();}
  }
  $n=Node::create(["type"=>"article","title"=>"sna_del_node"]);$n->save();$nid=$n->id();
  PathAlias::create(["path"=>"/node/".$nid,"alias"=>"/sna-old-alias","langcode"=>"en"])->save();
  print "nid=".$nid."\n";
' 2>/dev/null
drush cr >/dev/null 2>&1
echo "reset: sna_del_node present WITH alias /sna-old-alias"
