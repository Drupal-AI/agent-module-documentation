#!/usr/bin/env bash
# Execution RESET: protected Article "NKT Render" with EMPTY machine name so the token does NOT
# resolve to the nid yet (verify FAILs). Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\Node;
  $s = \Drupal::entityTypeManager()->getStorage("node");
  $n = ($x = $s->loadByProperties(["title" => "NKT Render"])) ? reset($x) : Node::create(["type"=>"article","title"=>"NKT Render"]);
  $n->set("node_keeper", TRUE);
  $n->set("keeper_machine_name", "");
  $n->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: 'NKT Render' node_keeper=1 keeper_machine_name=(empty)"
