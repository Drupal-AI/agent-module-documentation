#!/usr/bin/env bash
# Introspection SETUP: create a text format iv_tag (Insert View enabled) and a Basic page node
# titled "IV Probe Landing" whose body embeds a specific view/display/limit with an
# insert_view tag, so the agent must find the node and read the live body value.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\Node;
  $storage = \Drupal::entityTypeManager()->getStorage("filter_format");
  if (!$storage->load("iv_tag")) {
    $storage->create(["format" => "iv_tag", "name" => "IV Tag format", "weight" => 42])->save();
  }
  $fmt = $storage->load("iv_tag");
  $fmt->setFilterConfig("insert_view", ["id" => "insert_view", "provider" => "insert_view", "status" => TRUE, "weight" => 0, "settings" => []]);
  $fmt->save();
  $nodes = \Drupal::entityTypeManager()->getStorage("node")->loadByProperties(["title" => "IV Probe Landing"]);
  $node = $nodes ? reset($nodes) : Node::create(["type" => "article", "title" => "IV Probe Landing", "uid" => 1]);
  $node->set("body", [
    "value" => "<p>Our newest stories:</p>[view:archive=block_1=2019/06=limit:4]",
    "format" => "iv_tag",
  ]);
  $node->setPublished()->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: node 'IV Probe Landing' body embeds [view:archive=block_1=2019/06=limit:4] in format iv_tag"
