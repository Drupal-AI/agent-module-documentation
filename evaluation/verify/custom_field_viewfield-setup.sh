#!/usr/bin/env bash
# Introspection SETUP (custom_field_viewfield): create content type cf_vf_eval with a Custom
# Field field_cf_vf that has a viewfield column "listing", and configure the Custom Field widget
# so that subfield uses the viewfield_select widget. Lets an agent read back the viewfield column
# and its subfield widget. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\NodeType;
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!NodeType::load("cf_vf_eval")) { NodeType::create(["type"=>"cf_vf_eval","name"=>"CF Viewfield Eval"])->save(); }
  if (!FieldStorageConfig::loadByName("node","field_cf_vf")) {
    FieldStorageConfig::create(["field_name"=>"field_cf_vf","entity_type"=>"node","type"=>"custom","cardinality"=>1,
      "settings"=>["columns"=>["listing"=>["name"=>"listing","type"=>"viewfield","target_type"=>"view"]]]])->save();
  }
  if (!FieldConfig::loadByName("node","cf_vf_eval","field_cf_vf")) {
    FieldConfig::create(["field_name"=>"field_cf_vf","entity_type"=>"node","bundle"=>"cf_vf_eval","label"=>"Sections",
      "settings"=>["field_settings"=>["listing"=>["label"=>"Listing"]]]])->save();
  }
  $s=\Drupal::entityTypeManager()->getStorage("entity_form_display");
  $fd=$s->load("node.cf_vf_eval.default") ?: $s->create(["targetEntityType"=>"node","bundle"=>"cf_vf_eval","mode"=>"default","status"=>true]);
  $fd->setComponent("field_cf_vf",["type"=>"custom_stacked","region"=>"content","weight"=>5,
    "settings"=>["fields"=>["listing"=>["type"=>"viewfield_select","weight"=>0]]]])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: cf_vf_eval/field_cf_vf has viewfield column listing, subfield widget viewfield_select"
