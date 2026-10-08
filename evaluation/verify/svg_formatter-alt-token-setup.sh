#!/usr/bin/env bash
# Introspection SETUP: create a file field field_svgf_alt on Article rendered with
# svg_formatter in NON-inline mode with a token-driven alt string, so the agent must read the
# live formatter settings to report the alt token. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_svgf_alt")) {
    FieldStorageConfig::create([
      "field_name" => "field_svgf_alt", "entity_type" => "node", "type" => "file",
    ])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_svgf_alt")) {
    FieldConfig::create([
      "field_name" => "field_svgf_alt", "entity_type" => "node", "bundle" => "article",
      "label" => "SVGF Alt Logo", "settings" => ["file_extensions" => "svg"],
    ])->save();
  }
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $vd->setComponent("field_svgf_alt", [
    "type" => "svg_formatter", "label" => "hidden", "weight" => 81, "region" => "content",
    "settings" => [
      "inline" => FALSE, "sanitize" => TRUE, "apply_dimensions" => FALSE,
      "width" => 100, "height" => 100,
      "enable_alt" => TRUE, "alt_string" => "[node:title] vector mark",
      "enable_title" => FALSE, "title_string" => "",
    ],
    "third_party_settings" => [],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: node.article field_svgf_alt svg_formatter alt_string='[node:title] vector mark'"
