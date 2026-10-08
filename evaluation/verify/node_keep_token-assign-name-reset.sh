#!/usr/bin/env bash
# Execution RESET: protected Article "NKT Task" with EMPTY keeper_machine_name so verify FAILs.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\Node;
  $s = \Drupal::entityTypeManager()->getStorage("node");
  $n = ($x = $s->loadByProperties(["title" => "NKT Task"])) ? reset($x) : Node::create(["type"=>"article","title"=>"NKT Task"]);
  $n->set("node_keeper", TRUE);
  $n->set("keeper_machine_name", "");
  $n->save();
' >/dev/null 2>&1
echo "reset: 'NKT Task' node_keeper=1 keeper_machine_name=(empty)"
