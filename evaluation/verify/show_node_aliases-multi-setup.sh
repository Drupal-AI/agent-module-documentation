#!/usr/bin/env bash
# Introspection SETUP: node sna_multi_node with TWO aliases. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\Node;
  use Drupal\path_alias\Entity\PathAlias;
  $ids=\Drupal::entityTypeManager()->getStorage("node")->getQuery()->accessCheck(FALSE)->condition("title","sna_multi_node")->execute();
  if ($ids){$nid=reset($ids);} else {$n=Node::create(["type"=>"article","title"=>"sna_multi_node"]);$n->save();$nid=$n->id();}
  foreach (["/sna-multi-one","/sna-multi-two"] as $a) {
    if (!\Drupal::entityTypeManager()->getStorage("path_alias")->loadByProperties(["path"=>"/node/".$nid,"alias"=>$a])) {
      PathAlias::create(["path"=>"/node/".$nid,"alias"=>$a,"langcode"=>"en"])->save();
    }
  }
  print "nid=".$nid."\n";
' 2>/dev/null
drush cr >/dev/null 2>&1
echo "setup: sna_multi_node has aliases /sna-multi-one and /sna-multi-two"
