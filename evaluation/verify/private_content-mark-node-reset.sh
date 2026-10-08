#!/usr/bin/env bash
# Execution RESET: ensure a public Article node 'PC Task Node' exists with private=0 so verify
# FAILS until the agent marks it private. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\Node;
  $ids = \Drupal::entityQuery("node")->condition("title","PC Task Node")->accessCheck(FALSE)->execute();
  if ($ids) { $n = Node::load(reset($ids)); $n->set("private",0); $n->save(); }
  else { Node::create(["type"=>"article","title"=>"PC Task Node","status"=>1,"private"=>0])->save(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: 'PC Task Node' present with private=0 (public)"
