#!/usr/bin/env bash
# Execution RESET: ensure cfmedia_eval + Custom Field field_cfmedia_disp (entity_reference/media
# column 'image') exist, and force its per-column widget to a NON-media widget
# (entity_reference_autocomplete) so verify FAILS until switched to media_library_widget. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\NodeType;
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!NodeType::load("cfmedia_eval")) { NodeType::create(["type"=>"cfmedia_eval","name"=>"CF Media Eval"])->save(); }
  if (!FieldStorageConfig::loadByName("node","field_cfmedia_disp")) {
    FieldStorageConfig::create(["field_name"=>"field_cfmedia_disp","entity_type"=>"node","type"=>"custom","cardinality"=>1,
      "settings"=>["columns"=>["image"=>["name"=>"image","type"=>"entity_reference","target_type"=>"media"]]]])->save();
  }
  if (!FieldConfig::loadByName("node","cfmedia_eval","field_cfmedia_disp")) {
    FieldConfig::create(["field_name"=>"field_cfmedia_disp","entity_type"=>"node","bundle"=>"cfmedia_eval","label"=>"Disp"])->save();
  }
  $fd = \Drupal::service("entity_display.repository")->getFormDisplay("node","cfmedia_eval","default");
  $fd->setComponent("field_cfmedia_disp", ["type"=>"custom_flex","weight"=>12,"region"=>"content",
    "settings"=>["fields"=>["image"=>["type"=>"entity_reference_autocomplete"]]]])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: field_cfmedia_disp image widget forced to entity_reference_autocomplete"
