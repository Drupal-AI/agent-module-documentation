#!/usr/bin/env bash
# Introspection SETUP (insert_responsive_image): create a namespaced Responsive Image style
# (insert_ri_demo) and an image field field_insert_ri on Article (two-save so image_image sticks)
# with the parent Insert styles enabling responsive_image__insert_ri_demo, so an agent can read back
# which responsive insert style is enabled. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\responsive_image\Entity\ResponsiveImageStyle;
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!ResponsiveImageStyle::load("insert_ri_demo")) {
    $g = array_keys(\Drupal::service("breakpoint.manager")->getGroups());
    ResponsiveImageStyle::create(["id" => "insert_ri_demo", "label" => "Insert RI Demo", "breakpoint_group" => $g[0], "fallback_image_style" => "thumbnail"])->save();
  }
  if (!FieldStorageConfig::loadByName("node", "field_insert_ri")) {
    FieldStorageConfig::create(["field_name" => "field_insert_ri", "entity_type" => "node", "type" => "image"])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_insert_ri")) {
    FieldConfig::create(["field_name" => "field_insert_ri", "entity_type" => "node", "bundle" => "article", "label" => "RI Known"])->save();
  }
  $s = \Drupal::entityTypeManager()->getStorage("entity_form_display");
  $fd = $s->load("node.article.default");
  $fd->setComponent("field_insert_ri", ["type" => "image_image", "weight" => 63, "region" => "content"])->save();
  $fd = $s->load("node.article.default");
  $fd->setComponent("field_insert_ri", [
    "type" => "image_image", "weight" => 63, "region" => "content",
    "third_party_settings" => ["insert" => ["styles" => ["responsive_image__insert_ri_demo" => "responsive_image__insert_ri_demo"], "default" => "responsive_image__insert_ri_demo", "auto_image_style" => "image", "link_image" => NULL, "width" => "", "rotate" => FALSE]],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: field_insert_ri image_image enables responsive_image__insert_ri_demo (responsive style insert_ri_demo)"
