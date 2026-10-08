#!/usr/bin/env bash
# MEDIUM / introspection setup for slick_entityreference "which optionset" case.
# Creates a distinctive Slick optionset (eval_er_carousel), a multi-value entity_reference
# field field_ser_os on node.article, and points the article default display at the
# slick_entityreference_vanilla formatter USING that optionset, so an agent can read which
# optionset the carousel uses back off the live config.
# Field creation and display config run in SEPARATE drush requests (cache rebuild between)
# so the newly created field is fully registered before it is placed on the display.
set -uo pipefail
cd /var/www/html
drush php:eval '
  error_reporting(E_ERROR);
  if (!\Drupal\slick\Entity\Slick::load("eval_er_carousel")) {
    \Drupal\slick\Entity\Slick::create(["id"=>"eval_er_carousel","name"=>"eval_er_carousel","label"=>"Eval ER Carousel"])->save();
  }
  if (!\Drupal\field\Entity\FieldStorageConfig::loadByName("node","field_ser_os")) {
    \Drupal\field\Entity\FieldStorageConfig::create([
      "field_name"=>"field_ser_os","entity_type"=>"node","type"=>"entity_reference",
      "cardinality"=>-1,"settings"=>["target_type"=>"node"],
    ])->save();
  }
  if (!\Drupal\field\Entity\FieldConfig::loadByName("node","article","field_ser_os")) {
    \Drupal\field\Entity\FieldConfig::create([
      "field_name"=>"field_ser_os","entity_type"=>"node","bundle"=>"article",
      "label"=>"Slick refs (eval optionset)",
    ])->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
drush php:eval '
  error_reporting(E_ERROR);
  \Drupal::service("entity_display.repository")->getViewDisplay("node","article","default")
    ->setComponent("field_ser_os",[
      "type"=>"slick_entityreference_vanilla","label"=>"hidden",
      "settings"=>["optionset"=>"eval_er_carousel","view_mode"=>"default"],
    ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: node.article field_ser_os display -> slick_entityreference_vanilla (optionset=eval_er_carousel)"
