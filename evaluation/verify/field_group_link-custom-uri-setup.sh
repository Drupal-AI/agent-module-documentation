#!/usr/bin/env bash
# Introspection SETUP: build a namespaced Article view mode "fgl_uri" whose field_group_link
# group group_fgl_promo uses target=custom_uri with a tokenised custom URL, so the agent must
# read the live entity_view_display to report the exact URI. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\Core\Entity\Entity\EntityViewMode;
  use Drupal\field\Entity\FieldConfig;
  use Drupal\field\Entity\FieldStorageConfig;
  if (!EntityViewMode::load("node.fgl_uri")) {
    EntityViewMode::create([
      "id" => "node.fgl_uri", "targetEntityType" => "node", "label" => "FGL Uri",
    ])->save();
  }
  if (!FieldStorageConfig::loadByName("node", "field_fgl_promo_text")) {
    FieldStorageConfig::create([
      "field_name" => "field_fgl_promo_text", "entity_type" => "node", "type" => "string",
    ])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_fgl_promo_text")) {
    FieldConfig::create([
      "field_name" => "field_fgl_promo_text", "entity_type" => "node", "bundle" => "article",
      "label" => "FGL Promo Text",
    ])->save();
  }
  $s = \Drupal::entityTypeManager()->getStorage("entity_view_display");
  $vd = $s->load("node.article.fgl_uri") ?: $s->create([
    "targetEntityType" => "node", "bundle" => "article", "mode" => "fgl_uri", "status" => TRUE,
  ]);
  $vd->setStatus(TRUE);
  $vd->setComponent("field_fgl_promo_text", ["type" => "string", "label" => "hidden", "weight" => 1, "region" => "content"]);
  $vd->setThirdPartySetting("field_group", "group_fgl_promo", [
    "children" => ["field_fgl_promo_text"], "label" => "FGL Promo", "parent_name" => "",
    "region" => "content", "weight" => 5, "format_type" => "link",
    "format_settings" => [
      "label" => "FGL Promo", "classes" => "", "id" => "",
      "show_empty_fields" => FALSE, "label_as_html" => FALSE,
      "target" => "custom_uri",
      "custom_uri" => "https://promo.example.com/article/[node:nid]",
      "target_attribute" => "default",
    ],
  ]);
  $vd->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: node.article.fgl_uri group_fgl_promo target=custom_uri custom_uri=https://promo.example.com/article/[node:nid]"
