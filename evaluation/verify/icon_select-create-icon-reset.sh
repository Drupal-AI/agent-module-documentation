#!/usr/bin/env bash
# Execution RESET: ensure the icon_select 'icons' vocabulary + fields exist, then remove any
# icon term with symbol ID is_task_heart so verify FAILS until the agent creates it. Idempotent.
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
  foreach (\Drupal::entityTypeManager()->getStorage("taxonomy_term")->loadByProperties(["vid"=>"icons","field_symbol_id"=>"is_task_heart"]) as $t) { $t->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: icons vocab/fields present, no term with field_symbol_id=is_task_heart"
