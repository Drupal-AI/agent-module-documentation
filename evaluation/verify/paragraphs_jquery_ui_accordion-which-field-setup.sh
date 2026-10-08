#!/usr/bin/env bash
# Introspection SETUP: create a multi-value paragraph reference field on Article and display it
# with the jQuery UI accordion formatter, so an agent can find which field renders as an accordion.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node","field_pjqa_ref")) {
    FieldStorageConfig::create(["field_name"=>"field_pjqa_ref","entity_type"=>"node","type"=>"entity_reference_revisions","cardinality"=>-1,"settings"=>["target_type"=>"paragraph"]])->save();
  }
  if (!FieldConfig::loadByName("node","article","field_pjqa_ref")) {
    FieldConfig::create(["field_name"=>"field_pjqa_ref","entity_type"=>"node","bundle"=>"article","label"=>"Accordion sections"])->save();
  }
  $vd=\Drupal::service("entity_display.repository")->getViewDisplay("node","article","default");
  $vd->setComponent("field_pjqa_ref",["type"=>"paragraphs_jquery_ui_accordion_formatter","region"=>"content","weight"=>60,"settings"=>["bundle"=>"pjqa_item","title"=>"field_pjqa_title","content"=>"field_pjqa_body","view_mode"=>"default","active"=>1]])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: node.article field_pjqa_ref shown with accordion formatter"
