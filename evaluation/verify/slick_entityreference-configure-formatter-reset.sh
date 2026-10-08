#!/usr/bin/env bash
# HARD / execution reset for slick_entityreference "configure the formatter" case.
# Ensures a multi-value entity_reference field field_ser_hard exists on node.article
# (creates it if needed), then forces its default-view-display format back to a NON-slick
# baseline (entity_reference_label) so the verify script FAILs until the agent switches it
# to the slick_entityreference_vanilla formatter.
# Field creation and display config run in SEPARATE drush requests (cache rebuild between)
# so a freshly created field is fully registered before it is placed on the display.
set -uo pipefail
cd /var/www/html
drush php:eval '
  error_reporting(E_ERROR);
  if (!\Drupal\field\Entity\FieldStorageConfig::loadByName("node","field_ser_hard")) {
    \Drupal\field\Entity\FieldStorageConfig::create([
      "field_name"=>"field_ser_hard","entity_type"=>"node","type"=>"entity_reference",
      "cardinality"=>-1,"settings"=>["target_type"=>"node"],
    ])->save();
  }
  if (!\Drupal\field\Entity\FieldConfig::loadByName("node","article","field_ser_hard")) {
    \Drupal\field\Entity\FieldConfig::create([
      "field_name"=>"field_ser_hard","entity_type"=>"node","bundle"=>"article",
      "label"=>"Slick refs (eval hard)",
    ])->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
drush php:eval '
  error_reporting(E_ERROR);
  \Drupal::service("entity_display.repository")->getViewDisplay("node","article","default")
    ->setComponent("field_ser_hard",[
      "type"=>"entity_reference_label","label"=>"above","settings"=>["link"=>TRUE],
    ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: node.article field_ser_hard exists, display format = entity_reference_label (non-slick baseline)"
