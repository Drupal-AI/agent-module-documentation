#!/usr/bin/env bash
# Execution RESET: cfeb_eval + field_cfeb_ref (entity_reference col ref) with ref widget forced
# to entity_reference_autocomplete so verify FAILS until switched. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\NodeType;
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!NodeType::load("cfeb_eval")) { NodeType::create(["type"=>"cfeb_eval","name"=>"CFEB Eval"])->save(); }
  if (!FieldStorageConfig::loadByName("node","field_cfeb_ref")) {
    FieldStorageConfig::create(["field_name"=>"field_cfeb_ref","entity_type"=>"node","type"=>"custom","cardinality"=>1,
      "settings"=>["columns"=>["ref"=>["name"=>"ref","type"=>"entity_reference","target_type"=>"node"]]]])->save();
  }
  if (!FieldConfig::loadByName("node","cfeb_eval","field_cfeb_ref")) {
    FieldConfig::create(["field_name"=>"field_cfeb_ref","entity_type"=>"node","bundle"=>"cfeb_eval","label"=>"Ref"])->save();
  }
  $fd=\Drupal::service("entity_display.repository")->getFormDisplay("node","cfeb_eval","default");
  $fd->setComponent("field_cfeb_ref",["type"=>"custom_flex","region"=>"content","weight"=>5,
    "settings"=>["fields"=>["ref"=>["type"=>"entity_reference_autocomplete"]]]])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: field_cfeb_ref ref widget forced to entity_reference_autocomplete"
