#!/usr/bin/env bash
# Introspection SETUP: create link field field_btl_known on Article and display it with the
# button_link formatter (btn_type=btn-success) on the default view display. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_btl_known")) {
    FieldStorageConfig::create(["field_name" => "field_btl_known", "entity_type" => "node", "type" => "link"])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_btl_known")) {
    FieldConfig::create(["field_name" => "field_btl_known", "entity_type" => "node", "bundle" => "article", "label" => "Known CTA"])->save();
  }
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $vd->setComponent("field_btl_known", ["type" => "button_link", "label" => "hidden", "weight" => 50, "region" => "content", "settings" => ["btn_type" => "btn-success"]])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: node.article field_btl_known displayed with button_link btn_type=btn-success"
