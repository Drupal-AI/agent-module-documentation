#!/usr/bin/env bash
# Execution RESET: ensure the 'icons' vocabulary exists, then ensure an entity_reference field
# field_is_task_icon on Article targets it with the DEFAULT autocomplete widget / label
# formatter (NOT icon_select), so verify FAILS until the agent switches widget+formatter.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\taxonomy\Entity\Vocabulary;
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  use Drupal\taxonomy\Entity\Term;
  if (!Vocabulary::load("icons")) { Vocabulary::create(["vid"=>"icons","name"=>"Icons"])->save(); }
  if (!FieldStorageConfig::loadByName("taxonomy_term","field_symbol_id")) { FieldStorageConfig::create(["field_name"=>"field_symbol_id","entity_type"=>"taxonomy_term","type"=>"string","settings"=>["max_length"=>255]])->save(); }
  if (!FieldConfig::loadByName("taxonomy_term","icons","field_symbol_id")) { FieldConfig::create(["field_name"=>"field_symbol_id","entity_type"=>"taxonomy_term","bundle"=>"icons","label"=>"Symbol ID","required"=>true])->save(); }
  if (!FieldStorageConfig::loadByName("taxonomy_term","field_svg_file")) { FieldStorageConfig::create(["field_name"=>"field_svg_file","entity_type"=>"taxonomy_term","type"=>"file","settings"=>["uri_scheme"=>"public"]])->save(); }
  if (!FieldConfig::loadByName("taxonomy_term","icons","field_svg_file")) { FieldConfig::create(["field_name"=>"field_svg_file","entity_type"=>"taxonomy_term","bundle"=>"icons","label"=>"SVG File"])->save(); }
  if (!FieldStorageConfig::loadByName("node","field_is_task_icon")) { FieldStorageConfig::create(["field_name"=>"field_is_task_icon","entity_type"=>"node","type"=>"entity_reference","settings"=>["target_type"=>"taxonomy_term"]])->save(); }
  if (!FieldConfig::loadByName("node","article","field_is_task_icon")) { FieldConfig::create(["field_name"=>"field_is_task_icon","entity_type"=>"node","bundle"=>"article","label"=>"Task Icon","settings"=>["handler"=>"default:taxonomy_term","handler_settings"=>["target_bundles"=>["icons"=>"icons"]]]])->save(); }
  $repo = \Drupal::service("entity_display.repository");
  $repo->getFormDisplay("node","article","default")->setComponent("field_is_task_icon",["type"=>"entity_reference_autocomplete","weight"=>60])->save();
  $repo->getViewDisplay("node","article","default")->setComponent("field_is_task_icon",["type"=>"entity_reference_label","weight"=>60])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: field_is_task_icon present with default autocomplete widget / label formatter"
