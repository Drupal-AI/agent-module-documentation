#!/usr/bin/env bash
# Execution RESET: ensure a Link field field_url_embed_task exists on Article, with its
# default-display component set to the plain 'link' formatter (NOT url_embed), so verify
# FAILS until the agent switches it to the url_embed formatter with responsive wrapping.
# Creates the field if missing. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_url_embed_task")) {
    FieldStorageConfig::create([
      "field_name" => "field_url_embed_task", "entity_type" => "node",
      "type" => "link",
    ])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_url_embed_task")) {
    FieldConfig::create([
      "field_name" => "field_url_embed_task", "entity_type" => "node",
      "bundle" => "article", "label" => "Task Embed Link",
    ])->save();
  }
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  if (!$vd) {
    $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->create([
      "targetEntityType" => "node", "bundle" => "article", "mode" => "default", "status" => TRUE,
    ]);
  }
  $vd->setComponent("field_url_embed_task", [
    "type" => "link", "weight" => 50, "region" => "content", "label" => "above",
    "settings" => [], "third_party_settings" => [],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: node.article field_url_embed_task present, default display uses plain link formatter"
