#!/usr/bin/env bash
# Execution RESET: field_erfl_task exists on Article with the DEFAULT entity_reference_label
# formatter, so verify FAILS until the agent switches it to the Facet link formatter.
set -uo pipefail
cd /var/www/html
drush php:eval '
  if (!\Drupal\field\Entity\FieldStorageConfig::loadByName("node","field_erfl_task")) {
    \Drupal\field\Entity\FieldStorageConfig::create(["field_name"=>"field_erfl_task","entity_type"=>"node","type"=>"entity_reference","settings"=>["target_type"=>"node"]])->save();
  }
  if (!\Drupal\field\Entity\FieldConfig::loadByName("node","article","field_erfl_task")) {
    \Drupal\field\Entity\FieldConfig::create(["field_name"=>"field_erfl_task","entity_type"=>"node","bundle"=>"article","label"=>"ERFL Task"])->save();
  }
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $vd->setComponent("field_erfl_task",["type"=>"entity_reference_label","settings"=>["link"=>true],"label"=>"above","weight"=>52,"region"=>"content"])->save();
' >/dev/null 2>&1
echo "reset: field_erfl_task uses entity_reference_label formatter"
