#!/usr/bin/env bash
# Execution RESET (insert_responsive_image): create the namespaced Responsive Image style
# insert_ri_demo and an image field field_insert_ritask on Article (two-save) with Insert enabled but
# only the "Original image" style (NOT the responsive style), so verify FAILS until the agent enables
# responsive_image__insert_ri_demo. Idempotent. Exit 0.
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
  if (!FieldStorageConfig::loadByName("node", "field_insert_ritask")) {
    FieldStorageConfig::create(["field_name" => "field_insert_ritask", "entity_type" => "node", "type" => "image"])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_insert_ritask")) {
    FieldConfig::create(["field_name" => "field_insert_ritask", "entity_type" => "node", "bundle" => "article", "label" => "RI Task"])->save();
  }
  $s = \Drupal::entityTypeManager()->getStorage("entity_form_display");
  $fd = $s->load("node.article.default");
  $fd->setComponent("field_insert_ritask", ["type" => "image_image", "weight" => 63, "region" => "content"])->save();
  $fd = $s->load("node.article.default");
  $fd->setComponent("field_insert_ritask", [
    "type" => "image_image", "weight" => 63, "region" => "content",
    "third_party_settings" => ["insert" => ["styles" => ["image" => "image"], "default" => "insert__auto", "auto_image_style" => "image", "link_image" => NULL, "width" => "", "rotate" => FALSE]],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: field_insert_ritask image_image, Insert styles=[image] (responsive style NOT enabled); responsive style insert_ri_demo exists"
