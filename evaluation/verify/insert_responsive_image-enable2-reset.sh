#!/usr/bin/env bash
# Execution RESET (insert_responsive_image): create the responsive image style insert_ri_demo2 and
# an image field field_insert_ritask2 on Article (two-save so image_image sticks) with Insert
# enabled but only the plain 'image' insert style (NO responsive style), so verify FAILS until the
# agent enables responsive_image__insert_ri_demo2. Idempotent. Exit 0.
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
  if (!FieldStorageConfig::loadByName("node", "field_insert_ritask2")) {
    FieldStorageConfig::create(["field_name" => "field_insert_ritask2", "entity_type" => "node", "type" => "image"])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_insert_ritask2")) {
    FieldConfig::create(["field_name" => "field_insert_ritask2", "entity_type" => "node", "bundle" => "article", "label" => "RI Task 2"])->save();
  }
  $s = \Drupal::entityTypeManager()->getStorage("entity_form_display");
  $fd = $s->load("node.article.default");
  $fd->setComponent("field_insert_ritask2", ["type" => "image_image", "weight" => 67, "region" => "content"])->save();
  $fd = $s->load("node.article.default");
  $fd->setComponent("field_insert_ritask2", [
    "type" => "image_image", "weight" => 67, "region" => "content",
    "third_party_settings" => ["insert" => ["styles" => ["image" => "image"], "default" => "image", "auto_image_style" => "image", "link_image" => NULL, "width" => "", "rotate" => FALSE]],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: field_insert_ritask2 image_image, Insert enabled with only the plain image style (no responsive style)"
