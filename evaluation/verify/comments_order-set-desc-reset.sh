#!/usr/bin/env bash
# Execution RESET: ensure comment field field_co_task exists on node.article with
# comments_order order forced to ASC (oldest first), so verify FAILS until the agent sets it
# to DESC. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_co_task")) {
    FieldStorageConfig::create([
      "field_name" => "field_co_task", "entity_type" => "node",
      "type" => "comment", "settings" => ["comment_type" => "comment_forum"],
    ])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_co_task")) {
    FieldConfig::create([
      "field_name" => "field_co_task", "entity_type" => "node",
      "bundle" => "article", "label" => "Task Comments",
    ])->save();
  }
  $f = FieldConfig::loadByName("node", "article", "field_co_task");
  $f->setThirdPartySetting("comments_order", "order", "ASC");
  $f->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: node.article field_co_task comments_order.order=ASC"
