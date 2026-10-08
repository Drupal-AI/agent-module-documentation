#!/usr/bin/env bash
# Introspection SETUP: create a file field field_svgf_known on Article (svg extension) and
# configure its component in the default VIEW display to use the svg_formatter formatter with
# known inline/dimension settings, so an inspecting agent can read them back. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_svgf_known")) {
    FieldStorageConfig::create([
      "field_name" => "field_svgf_known", "entity_type" => "node", "type" => "file",
    ])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_svgf_known")) {
    FieldConfig::create([
      "field_name" => "field_svgf_known", "entity_type" => "node", "bundle" => "article",
      "label" => "SVGF Known Logo", "settings" => ["file_extensions" => "svg"],
    ])->save();
  }
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $vd->setComponent("field_svgf_known", [
    "type" => "svg_formatter", "label" => "hidden", "weight" => 80, "region" => "content",
    "settings" => [
      "inline" => TRUE, "sanitize" => TRUE, "apply_dimensions" => TRUE,
      "width" => 320, "height" => 240,
      "enable_alt" => TRUE, "alt_string" => "", "enable_title" => TRUE, "title_string" => "",
    ],
    "third_party_settings" => [],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: node.article field_svgf_known uses svg_formatter inline=true width=320 height=240"
