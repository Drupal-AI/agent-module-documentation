#!/usr/bin/env bash
# Introspection SETUP (insert_responsive_image): create a second namespaced Responsive Image style
# (insert_ri_demo2) and an image field field_insert_ri2 on Article (two-save so image_image sticks)
# whose parent Insert styles enable responsive_image__insert_ri_demo2 as the default insert style,
# so an agent can read back that responsive insert style key. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\responsive_image\Entity\ResponsiveImageStyle;
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!ResponsiveImageStyle::load("insert_ri_demo2")) {
    $g = array_keys(\Drupal::service("breakpoint.manager")->getGroups());
    ResponsiveImageStyle::create(["id" => "insert_ri_demo2", "label" => "Insert RI Demo 2", "breakpoint_group" => $g[0], "fallback_image_style" => "medium"])->save();
  }
  if (!FieldStorageConfig::loadByName("node", "field_insert_ri2")) {
    FieldStorageConfig::create(["field_name" => "field_insert_ri2", "entity_type" => "node", "type" => "image"])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_insert_ri2")) {
    FieldConfig::create(["field_name" => "field_insert_ri2", "entity_type" => "node", "bundle" => "article", "label" => "RI Known 2"])->save();
  }
  $s = \Drupal::entityTypeManager()->getStorage("entity_form_display");
  $fd = $s->load("node.article.default");
  $fd->setComponent("field_insert_ri2", ["type" => "image_image", "weight" => 66, "region" => "content"])->save();
  $fd = $s->load("node.article.default");
  $fd->setComponent("field_insert_ri2", [
    "type" => "image_image", "weight" => 66, "region" => "content",
    "third_party_settings" => ["insert" => ["styles" => ["responsive_image__insert_ri_demo2" => "responsive_image__insert_ri_demo2"], "default" => "responsive_image__insert_ri_demo2", "auto_image_style" => "image", "link_image" => NULL, "width" => "", "rotate" => FALSE]],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: field_insert_ri2 image_image enables responsive_image__insert_ri_demo2 (responsive style insert_ri_demo2)"
