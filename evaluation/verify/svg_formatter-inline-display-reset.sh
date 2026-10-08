#!/usr/bin/env bash
# Execution RESET: ensure a file field field_svgf_task exists on Article (svg allowed) and
# force its component in core.entity_view_display.node.article.default back to the plain
# "file_default" formatter, so verify FAILS until the agent switches it to svg_formatter with
# inline output. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_svgf_task")) {
    FieldStorageConfig::create([
      "field_name" => "field_svgf_task", "entity_type" => "node", "type" => "file",
    ])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_svgf_task")) {
    FieldConfig::create([
      "field_name" => "field_svgf_task", "entity_type" => "node", "bundle" => "article",
      "label" => "SVGF Task Icon", "settings" => ["file_extensions" => "svg"],
    ])->save();
  }
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $vd->setComponent("field_svgf_task", [
    "type" => "file_default", "label" => "above", "weight" => 82, "region" => "content",
    "settings" => [], "third_party_settings" => [],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: node.article field_svgf_task set to file_default (not svg_formatter)"
