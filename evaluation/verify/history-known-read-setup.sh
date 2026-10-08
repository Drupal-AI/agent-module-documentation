#!/usr/bin/env bash
# Introspection SETUP: create a page node and record, in the {history} table, that user 1 read
# it at a known Unix timestamp, so the agent must query the live database. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\Node;
  $ids = \Drupal::entityQuery("node")->accessCheck(FALSE)->condition("title", "History Known Node")->execute();
  if (!$ids) {
    $n = Node::create(["type" => "page", "title" => "History Known Node", "status" => 1]);
    $n->save();
  }
  else {
    $n = Node::load(reset($ids));
  }
  \Drupal::database()->merge("history")
    ->keys(["uid" => 1, "nid" => $n->id()])
    ->fields(["timestamp" => 1900000000])
    ->execute();
  print "nid=" . $n->id() . "\n";
' 2>/dev/null
echo "setup: {history} row uid=1 nid=<History Known Node> timestamp=1900000000"
