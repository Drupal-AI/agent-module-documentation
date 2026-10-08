#!/usr/bin/env bash
# Introspection SETUP: protected Article "NKT Home Page" with keeper_machine_name=nkt_home. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\Node;
  $s = \Drupal::entityTypeManager()->getStorage("node");
  $n = ($x = $s->loadByProperties(["title" => "NKT Home Page"])) ? reset($x) : Node::create(["type"=>"article","title"=>"NKT Home Page"]);
  $n->set("node_keeper", TRUE);
  $n->set("keeper_machine_name", "nkt_home");
  $n->save();
' >/dev/null 2>&1
echo "setup: 'NKT Home Page' keeper_machine_name=nkt_home"
