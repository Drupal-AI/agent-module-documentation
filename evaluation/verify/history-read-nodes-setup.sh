#!/usr/bin/env bash
# Introspection SETUP: create two page nodes but record a {history} read row for only ONE of
# them (for user 1), so the agent must query the live history table to tell them apart.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\Node;
  $nids = [];
  foreach (["History Seen Node", "History Unseen Node"] as $title) {
    $ids = \Drupal::entityQuery("node")->accessCheck(FALSE)->condition("title", $title)->execute();
    if (!$ids) {
      $n = Node::create(["type" => "page", "title" => $title, "status" => 1]);
      $n->save();
    }
    else {
      $n = Node::load(reset($ids));
    }
    $nids[$title] = $n->id();
  }
  \Drupal::database()->delete("history")->condition("nid", array_values($nids), "IN")->execute();
  \Drupal::database()->merge("history")
    ->keys(["uid" => 1, "nid" => $nids["History Seen Node"]])
    ->fields(["timestamp" => 1900000001])
    ->execute();
  print "seen=" . $nids["History Seen Node"] . " unseen=" . $nids["History Unseen Node"] . "\n";
' 2>/dev/null
echo "setup: only 'History Seen Node' has a {history} row for uid 1"
