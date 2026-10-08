#!/usr/bin/env bash
# Introspection SETUP: create comment field field_co_created on node.article configured to
# order by the "Authored On" (created) field rather than comment id. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_co_created")) {
    FieldStorageConfig::create([
      "field_name" => "field_co_created", "entity_type" => "node",
      "type" => "comment", "settings" => ["comment_type" => "comment_forum"],
    ])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_co_created")) {
    FieldConfig::create([
      "field_name" => "field_co_created", "entity_type" => "node",
      "bundle" => "article", "label" => "Created-ordered Comments",
    ])->save();
  }
  $f = FieldConfig::loadByName("node", "article", "field_co_created");
  $f->setThirdPartySetting("comments_order", "order", "DESC");
  $f->setThirdPartySetting("comments_order", "created_order", 1);
  $f->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: node.article field_co_created comments_order.created_order=1"
