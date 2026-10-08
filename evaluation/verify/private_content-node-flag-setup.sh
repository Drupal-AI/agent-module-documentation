#!/usr/bin/env bash
# Introspection SETUP: create two Article nodes 'PC Alpha' (private=1) and 'PC Beta' (private=0)
# so the agent can determine which is private. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\Node;
  foreach (["PC Alpha","PC Beta"] as $title) {
    foreach (\Drupal::entityQuery("node")->condition("title",$title)->accessCheck(FALSE)->execute() as $nid) { Node::load($nid)->delete(); }
  }
  Node::create(["type"=>"article","title"=>"PC Alpha","status"=>1,"private"=>1])->save();
  Node::create(["type"=>"article","title"=>"PC Beta","status"=>1,"private"=>0])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: PC Alpha (private=1), PC Beta (private=0) created"
