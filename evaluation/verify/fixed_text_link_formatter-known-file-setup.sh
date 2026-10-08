#!/usr/bin/env bash
# Introspection SETUP: add a file field field_ftlf_file to Article and set its default view
# display to the fixed_text_file_url formatter with a known link_text. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_ftlf_file")) {
    FieldStorageConfig::create(["field_name"=>"field_ftlf_file","entity_type"=>"node","type"=>"file"])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_ftlf_file")) {
    FieldConfig::create(["field_name"=>"field_ftlf_file","entity_type"=>"node","bundle"=>"article","label"=>"FTLF File"])->save();
  }
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $vd->setComponent("field_ftlf_file", [
    "type"=>"fixed_text_file_url","label"=>"hidden","weight"=>51,"region"=>"content",
    "settings"=>["link_text"=>"Download the Report","link_class"=>"","open_in_new_window"=>TRUE],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: field_ftlf_file uses fixed_text_file_url, link_text=Download the Report"
