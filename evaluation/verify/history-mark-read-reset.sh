#!/usr/bin/env bash
# Execution RESET: make sure the target node exists and that NO {history} row exists for it,
# so verify fails until the agent records the read. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\Node;
  $ids = \Drupal::entityQuery("node")->accessCheck(FALSE)->condition("title", "History Task Node")->execute();
  if (!$ids) {
    $n = Node::create(["type" => "page", "title" => "History Task Node", "status" => 1]);
    $n->save();
  }
  else {
    $n = Node::load(reset($ids));
  }
  \Drupal::database()->delete("history")->condition("nid", $n->id())->execute();
  print "nid=" . $n->id() . "\n";
' 2>/dev/null
echo "reset: History Task Node present with no {history} rows"
