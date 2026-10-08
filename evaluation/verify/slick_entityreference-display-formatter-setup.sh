#!/usr/bin/env bash
# MEDIUM / introspection setup for slick_entityreference "which formatter" case.
# Creates a multi-value entity_reference field field_ser_med on node.article (if missing)
# and points the article default view display at the slick_entityreference_vanilla formatter
# with the 'default' Slick optionset, so an agent can read the live config back.
# Field creation and display config run in SEPARATE drush requests (with a cache rebuild
# between) so the newly created field is fully registered before it is placed on the display.
set -uo pipefail
cd /var/www/html
drush php:eval '
  error_reporting(E_ERROR);
  if (!\Drupal\field\Entity\FieldStorageConfig::loadByName("node","field_ser_med")) {
    \Drupal\field\Entity\FieldStorageConfig::create([
      "field_name"=>"field_ser_med","entity_type"=>"node","type"=>"entity_reference",
      "cardinality"=>-1,"settings"=>["target_type"=>"node"],
    ])->save();
  }
  if (!\Drupal\field\Entity\FieldConfig::loadByName("node","article","field_ser_med")) {
    \Drupal\field\Entity\FieldConfig::create([
      "field_name"=>"field_ser_med","entity_type"=>"node","bundle"=>"article",
      "label"=>"Slick refs (eval medium)",
    ])->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
drush php:eval '
  error_reporting(E_ERROR);
  \Drupal::service("entity_display.repository")->getViewDisplay("node","article","default")
    ->setComponent("field_ser_med",[
      "type"=>"slick_entityreference_vanilla","label"=>"hidden",
      "settings"=>["optionset"=>"default","view_mode"=>"default"],
    ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: node.article field_ser_med display -> slick_entityreference_vanilla (optionset=default)"
