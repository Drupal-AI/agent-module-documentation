#!/usr/bin/env bash
# Introspection SETUP: create a comment field field_co_known on node.article and set its
# comments_order order to DESC (newest first). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_co_known")) {
    FieldStorageConfig::create([
      "field_name" => "field_co_known", "entity_type" => "node",
      "type" => "comment", "settings" => ["comment_type" => "comment_forum"],
    ])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_co_known")) {
    FieldConfig::create([
      "field_name" => "field_co_known", "entity_type" => "node",
      "bundle" => "article", "label" => "Known Comments",
    ])->save();
  }
  $f = FieldConfig::loadByName("node", "article", "field_co_known");
  $f->setThirdPartySetting("comments_order", "order", "DESC");
  $f->setThirdPartySetting("comments_order", "children_natural_order", 1);
  $f->setThirdPartySetting("comments_order", "created_order", 0);
  $f->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: node.article field_co_known comments_order.order=DESC"
