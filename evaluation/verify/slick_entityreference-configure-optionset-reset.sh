#!/usr/bin/env bash
# HARD / execution reset for slick_entityreference "configure formatter WITH a specific
# optionset" case. Ensures a distinctive Slick optionset (eval_hard_set) and a multi-value
# entity_reference field field_ser_hard2 on node.article exist (creates them if needed),
# then forces the field's default-view-display format back to a NON-slick baseline so verify
# FAILs until the agent switches it to slick_entityreference_vanilla using eval_hard_set.
# Field creation and display config run in SEPARATE drush requests (cache rebuild between)
# so a freshly created field is fully registered before it is placed on the display.
set -uo pipefail
cd /var/www/html
drush php:eval '
  error_reporting(E_ERROR);
  if (!\Drupal\slick\Entity\Slick::load("eval_hard_set")) {
    \Drupal\slick\Entity\Slick::create(["id"=>"eval_hard_set","name"=>"eval_hard_set","label"=>"Eval Hard Set"])->save();
  }
  if (!\Drupal\field\Entity\FieldStorageConfig::loadByName("node","field_ser_hard2")) {
    \Drupal\field\Entity\FieldStorageConfig::create([
      "field_name"=>"field_ser_hard2","entity_type"=>"node","type"=>"entity_reference",
      "cardinality"=>-1,"settings"=>["target_type"=>"node"],
    ])->save();
  }
  if (!\Drupal\field\Entity\FieldConfig::loadByName("node","article","field_ser_hard2")) {
    \Drupal\field\Entity\FieldConfig::create([
      "field_name"=>"field_ser_hard2","entity_type"=>"node","bundle"=>"article",
      "label"=>"Slick refs (eval hard optionset)",
    ])->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
drush php:eval '
  error_reporting(E_ERROR);
  \Drupal::service("entity_display.repository")->getViewDisplay("node","article","default")
    ->setComponent("field_ser_hard2",[
      "type"=>"entity_reference_label","label"=>"above","settings"=>["link"=>TRUE],
    ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: field_ser_hard2 exists (non-slick baseline); optionset eval_hard_set available"
