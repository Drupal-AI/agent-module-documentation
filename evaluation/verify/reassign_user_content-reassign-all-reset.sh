#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\user\Entity\User;
  use Drupal\node\Entity\Node;
  $mk = function($name){ $u=\Drupal::entityTypeManager()->getStorage("user")->loadByProperties(["name"=>$name]); if($u){return reset($u);} $u=User::create(["name"=>$name,"mail"=>$name."@example.test","status"=>1]); $u->save(); return $u; };
  $src = $mk("ruc_source"); $dest = $mk("ruc_dest");
  $ns = \Drupal::entityTypeManager()->getStorage("node");
  // Remove any prior fixture nodes for a clean slate.
  foreach (["RUC All Node 1","RUC All Node 2"] as $t) {
    foreach ($ns->loadByProperties(["title"=>$t]) as $n) { $n->delete(); }
  }
  foreach (["RUC All Node 1","RUC All Node 2"] as $t) {
    Node::create(["type"=>"article","title"=>$t,"uid"=>$src->id()])->save();
  }
' >/dev/null 2>&1
echo "reset: ruc_source authors 2 nodes; ruc_dest exists"
