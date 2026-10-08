#!/usr/bin/env bash
# Introspection SETUP: create a plain string field field_hty_known on Article and set its
# default view-display formatter to the html_title ("HTML-title text") formatter, so an agent
# can read back which formatter renders it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_hty_known")) {
    FieldStorageConfig::create([
      "field_name" => "field_hty_known", "entity_type" => "node",
      "type" => "string",
    ])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_hty_known")) {
    FieldConfig::create([
      "field_name" => "field_hty_known", "entity_type" => "node",
      "bundle" => "article", "label" => "Known HTML Subtitle",
    ])->save();
  }
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $vd->setComponent("field_hty_known", ["type" => "html_title", "weight" => 50, "region" => "content", "label" => "hidden"])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: node.article field_hty_known uses view formatter html_title"
