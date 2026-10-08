#!/usr/bin/env bash
# Execution RESET: ensure Article has a long-text field field_dxprb_body whose default view
# display uses the plain 'text_default' formatter (NOT DXPR Builder), so verify FAILS until the
# agent switches the formatter to dxpr_builder_text. Creates the field if missing. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_dxprb_body")) {
    FieldStorageConfig::create([
      "field_name" => "field_dxprb_body", "entity_type" => "node", "type" => "text_long",
    ])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_dxprb_body")) {
    FieldConfig::create([
      "field_name" => "field_dxprb_body", "entity_type" => "node",
      "bundle" => "article", "label" => "DXPRB Body",
    ])->save();
  }
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $vd->setComponent("field_dxprb_body", ["type" => "text_default", "label" => "hidden", "weight" => 90, "region" => "content"])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: node.article field_dxprb_body present with formatter text_default (not DXPR)"
