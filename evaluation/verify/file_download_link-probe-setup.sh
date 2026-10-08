#!/usr/bin/env bash
# Introspection SETUP: create a file field on Article displayed with the file_download_link
# formatter and a distinctive link text, so an agent can read the display config back. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_fdl_probe")) {
    FieldStorageConfig::create(["field_name" => "field_fdl_probe", "entity_type" => "node", "type" => "file"])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_fdl_probe")) {
    FieldConfig::create(["field_name" => "field_fdl_probe", "entity_type" => "node", "bundle" => "article", "label" => "FDL Probe File"])->save();
  }
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $vd->setComponent("field_fdl_probe", [
    "type" => "file_download_link", "label" => "hidden", "weight" => 50, "region" => "content",
    "settings" => ["link_text" => "Grab It", "new_tab" => true, "force_download" => true, "force_download_filename" => "", "custom_classes" => ""],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: node.article field_fdl_probe uses file_download_link, link_text='Grab It'"
