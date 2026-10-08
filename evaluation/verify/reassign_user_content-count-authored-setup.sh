#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\user\Entity\User;
  use Drupal\node\Entity\Node;
  $us = \Drupal::entityTypeManager()->getStorage("user")->loadByProperties(["name" => "ruc_bulk"]);
  $u = $us ? reset($us) : User::create(["name"=>"ruc_bulk","mail"=>"ruc_bulk@example.test","status"=>1]);
  if ($u->isNew()) { $u->save(); }
  $existing = \Drupal::entityTypeManager()->getStorage("node")->getQuery()->accessCheck(FALSE)->condition("uid",$u->id())->count()->execute();
  for ($i = $existing; $i < 3; $i++) {
    Node::create(["type"=>"article","title"=>"RUC Bulk Node ".($i+1),"uid"=>$u->id()])->save();
  }
' >/dev/null 2>&1
echo "setup: ruc_bulk authors 3 nodes"
