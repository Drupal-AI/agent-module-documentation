#!/usr/bin/env bash
# Introspection SETUP: create a KNOWN node and store a KNOWN Statistics view count for it, so
# an inspecting agent can look up node_counter / the storage service and read the number back.
# Node title: "Statistics Eval Popular Post"; recorded total views: 42 (daycount 42 too).
# Removes any prior node of that title first so the state is unambiguous. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $storage = \Drupal::entityTypeManager()->getStorage("node");
  foreach ($storage->loadByProperties(["title" => "Statistics Eval Popular Post"]) as $old) {
    \Drupal::database()->delete("node_counter")->condition("nid", $old->id())->execute();
    $old->delete();
  }
  $node = \Drupal\node\Entity\Node::create(["type" => "article", "title" => "Statistics Eval Popular Post"]);
  $node->save();
  \Drupal::database()->merge("node_counter")
    ->key("nid", $node->id())
    ->fields(["totalcount" => 42, "daycount" => 42, "timestamp" => time()])
    ->execute();
  print "nid=" . $node->id() . " totalcount=42\n";
' 2>/dev/null
drush cr >/dev/null 2>&1
echo "setup: node 'Statistics Eval Popular Post' recorded with 42 total views"
