#!/usr/bin/env bash
# Execution RESET (custom_field_viewfield): create cf_vf_eval + field_cf_vf with a viewfield
# column "listing", but set that subfield's widget to the generic 'hidden' widget (NOT
# viewfield_select). verify FAILs until the agent selects the viewfield_select widget. Idempotent.
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
    "settings"=>["fields"=>["listing"=>["type"=>"hidden","weight"=>0]]]])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: field_cf_vf viewfield column uses hidden widget (not viewfield_select)"
