#!/usr/bin/env bash
# Execution RESET: create a file field on Article already using file_download_link with the
# default link text 'Download', so a "change link text to Download PDF" task fails until done.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_fdl_link")) {
    FieldStorageConfig::create(["field_name" => "field_fdl_link", "entity_type" => "node", "type" => "file"])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_fdl_link")) {
    FieldConfig::create(["field_name" => "field_fdl_link", "entity_type" => "node", "bundle" => "article", "label" => "FDL Link File"])->save();
  }
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $vd->setComponent("field_fdl_link", [
    "type" => "file_download_link", "label" => "hidden", "weight" => 50, "region" => "content",
    "settings" => ["link_text" => "Download", "new_tab" => true, "force_download" => true, "force_download_filename" => "", "custom_classes" => ""],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: node.article field_fdl_link uses file_download_link, link_text='Download'"
