#!/usr/bin/env bash
# Execution RESET: display field_pjqa_open with the accordion formatter but with active=0 (first
# panel NOT open), so verify FAILS until the agent sets it to open the first panel by default.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node","field_pjqa_open")) {
    FieldStorageConfig::create(["field_name"=>"field_pjqa_open","entity_type"=>"node","type"=>"entity_reference_revisions","cardinality"=>-1,"settings"=>["target_type"=>"paragraph"]])->save();
  }
  if (!FieldConfig::loadByName("node","article","field_pjqa_open")) {
    FieldConfig::create(["field_name"=>"field_pjqa_open","entity_type"=>"node","bundle"=>"article","label"=>"Open accordion"])->save();
  }
  $vd=\Drupal::service("entity_display.repository")->getViewDisplay("node","article","default");
  $vd->setComponent("field_pjqa_open",["type"=>"paragraphs_jquery_ui_accordion_formatter","region"=>"content","weight"=>63,"settings"=>["bundle"=>"pjqa_item","title"=>"field_pjqa_title","content"=>"field_pjqa_body","view_mode"=>"default","active"=>0]])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: field_pjqa_open accordion formatter active=0"
