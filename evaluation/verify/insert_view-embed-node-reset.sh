#!/usr/bin/env bash
# Execution RESET: ensure the text format iv_embed exists WITH the Insert View filter enabled,
# and delete any node titled "IV Embed Task", so verify FAILS on empty state. Idempotent.
# Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $storage = \Drupal::entityTypeManager()->getStorage("filter_format");
  if (!$storage->load("iv_embed")) {
    $storage->create(["format" => "iv_embed", "name" => "IV Embed format", "weight" => 44])->save();
  }
  $fmt = $storage->load("iv_embed");
  $fmt->setFilterConfig("insert_view", ["id" => "insert_view", "provider" => "insert_view", "status" => TRUE, "weight" => 0, "settings" => []]);
  $fmt->save();
  foreach (\Drupal::entityTypeManager()->getStorage("node")->loadByProperties(["title" => "IV Embed Task"]) as $node) { $node->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: filter_format iv_embed ready (insert_view enabled); node 'IV Embed Task' deleted"
