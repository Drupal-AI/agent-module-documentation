#!/usr/bin/env bash
# Execution RESET: create a multi-value paragraph reference field field_pjqa_task on Article and
# display it with the DEFAULT (non-accordion) paragraph formatter, so verify FAILS until the
# agent switches it to paragraphs_jquery_ui_accordion_formatter.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node","field_pjqa_task")) {
    FieldStorageConfig::create(["field_name"=>"field_pjqa_task","entity_type"=>"node","type"=>"entity_reference_revisions","cardinality"=>-1,"settings"=>["target_type"=>"paragraph"]])->save();
  }
  if (!FieldConfig::loadByName("node","article","field_pjqa_task")) {
    FieldConfig::create(["field_name"=>"field_pjqa_task","entity_type"=>"node","bundle"=>"article","label"=>"Sections"])->save();
  }
  $vd=\Drupal::service("entity_display.repository")->getViewDisplay("node","article","default");
  $vd->setComponent("field_pjqa_task",["type"=>"entity_reference_revisions_entity_view","region"=>"content","weight"=>62,"settings"=>["view_mode"=>"default"]])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: field_pjqa_task shown with default (non-accordion) formatter"
