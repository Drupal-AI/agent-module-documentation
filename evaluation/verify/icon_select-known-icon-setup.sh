#!/usr/bin/env bash
# Introspection SETUP: ensure the icon_select 'icons' vocabulary + fields exist (the module's
# shipped config), then create an icon term with a distinctive symbol ID so the agent can read
# it back. Idempotent. Exit 0.
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
  $e = \Drupal::entityTypeManager()->getStorage("taxonomy_term")->loadByProperties(["vid"=>"icons","field_symbol_id"=>"is_probe_star"]);
  if (!$e) { Term::create(["vid"=>"icons","name"=>"Probe Star","field_symbol_id"=>"is_probe_star"])->save(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: icons vocabulary has term with field_symbol_id=is_probe_star"
