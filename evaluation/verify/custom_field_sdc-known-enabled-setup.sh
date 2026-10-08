#!/usr/bin/env bash
# Introspection SETUP: bind cfsdc_eval default view display to SDC component navigation:message.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\NodeType;
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!NodeType::load("cfsdc_eval")) { NodeType::create(["type"=>"cfsdc_eval","name"=>"CF SDC Eval"])->save(); }
  if (!FieldStorageConfig::loadByName("node","field_cfsdc")) {
    FieldStorageConfig::create(["field_name"=>"field_cfsdc","entity_type"=>"node","type"=>"custom","cardinality"=>1,
      "settings"=>["columns"=>["label"=>["name"=>"label","type"=>"string","max_length"=>255]]]])->save();
  }
  if (!FieldConfig::loadByName("node","cfsdc_eval","field_cfsdc")) {
    FieldConfig::create(["field_name"=>"field_cfsdc","entity_type"=>"node","bundle"=>"cfsdc_eval","label"=>"SDC Field"])->save();
  }
  $s=\Drupal::entityTypeManager()->getStorage("entity_view_display");
  $vd=$s->load("node.cfsdc_eval.default") ?: $s->create(["targetEntityType"=>"node","bundle"=>"cfsdc_eval","mode"=>"default","status"=>true]);
  $vd->setThirdPartySetting("custom_field_sdc","settings",["enabled"=>TRUE,"component"=>"navigation:message","props"=>[],"slots"=>[]])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: cfsdc_eval default view display enabled with navigation:message"
