#!/usr/bin/env bash
# Introspection SETUP: create content type cfmedia_eval + Custom Field field_cfmedia_wid with an
# entity_reference(media) column 'image', and set its form-display per-column widget to
# media_library_widget. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\NodeType;
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!NodeType::load("cfmedia_eval")) { NodeType::create(["type"=>"cfmedia_eval","name"=>"CF Media Eval"])->save(); }
  if (!FieldStorageConfig::loadByName("node","field_cfmedia_wid")) {
    FieldStorageConfig::create(["field_name"=>"field_cfmedia_wid","entity_type"=>"node","type"=>"custom","cardinality"=>1,
      "settings"=>["columns"=>["image"=>["name"=>"image","type"=>"entity_reference","target_type"=>"media"]]]])->save();
  }
  if (!FieldConfig::loadByName("node","cfmedia_eval","field_cfmedia_wid")) {
    FieldConfig::create(["field_name"=>"field_cfmedia_wid","entity_type"=>"node","bundle"=>"cfmedia_eval","label"=>"Wid"])->save();
  }
  $fd = \Drupal::service("entity_display.repository")->getFormDisplay("node","cfmedia_eval","default");
  $fd->setComponent("field_cfmedia_wid", ["type"=>"custom_flex","weight"=>10,"region"=>"content",
    "settings"=>["fields"=>["image"=>["type"=>"media_library_widget","media_types"=>["image"]]]]])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: cfmedia_eval.field_cfmedia_wid image column widget=media_library_widget"
