#!/usr/bin/env bash
# Introspection SETUP: create link field field_btl_icon on Article, button_link formatter with
# icon_class 'fa fa-anchor' on the default view display. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_btl_icon")) {
    FieldStorageConfig::create(["field_name" => "field_btl_icon", "entity_type" => "node", "type" => "link"])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_btl_icon")) {
    FieldConfig::create(["field_name" => "field_btl_icon", "entity_type" => "node", "bundle" => "article", "label" => "Icon CTA"])->save();
  }
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $vd->setComponent("field_btl_icon", ["type" => "button_link", "label" => "hidden", "weight" => 51, "region" => "content", "settings" => ["btn_type" => "btn-primary", "icon_class" => "fa fa-anchor"]])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: node.article field_btl_icon button_link icon_class='fa fa-anchor'"
