#!/usr/bin/env bash
# Introspection SETUP: protected Article "NKT Probe" with keeper_machine_name=nkt_probe. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\Node;
  $s = \Drupal::entityTypeManager()->getStorage("node");
  $n = ($x = $s->loadByProperties(["title" => "NKT Probe"])) ? reset($x) : Node::create(["type"=>"article","title"=>"NKT Probe"]);
  $n->set("node_keeper", TRUE);
  $n->set("keeper_machine_name", "nkt_probe");
  $n->save();
' >/dev/null 2>&1
echo "setup: 'NKT Probe' node_keeper=1 keeper_machine_name=nkt_probe"
