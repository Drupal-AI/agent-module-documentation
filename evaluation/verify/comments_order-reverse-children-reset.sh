#!/usr/bin/env bash
# Execution RESET: ensure comment field field_co_thread exists on node.article with
# comments_order order=DESC and children_natural_order=1 (children kept natural), so verify
# FAILS until the agent disables natural children order (sets it to 0). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_co_thread")) {
    FieldStorageConfig::create([
      "field_name" => "field_co_thread", "entity_type" => "node",
      "type" => "comment", "settings" => ["comment_type" => "comment_forum"],
    ])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_co_thread")) {
    FieldConfig::create([
      "field_name" => "field_co_thread", "entity_type" => "node",
      "bundle" => "article", "label" => "Threaded Comments",
    ])->save();
  }
  $f = FieldConfig::loadByName("node", "article", "field_co_thread");
  $f->setThirdPartySetting("comments_order", "order", "DESC");
  $f->setThirdPartySetting("comments_order", "children_natural_order", 1);
  $f->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: node.article field_co_thread order=DESC children_natural_order=1"
