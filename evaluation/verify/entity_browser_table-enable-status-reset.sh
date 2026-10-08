#!/usr/bin/env bash
# Execution RESET: field_ebt_task2 uses the table widget but with the Status column OFF.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node","field_ebt_task2")) {
    FieldStorageConfig::create(["field_name"=>"field_ebt_task2","entity_type"=>"node","type"=>"entity_reference","cardinality"=>-1,"settings"=>["target_type"=>"node"]])->save();
  }
  if (!FieldConfig::loadByName("node","article","field_ebt_task2")) {
    FieldConfig::create(["field_name"=>"field_ebt_task2","entity_type"=>"node","bundle"=>"article","label"=>"EBT Task2","settings"=>["handler"=>"default:node"]])->save();
  }
  $fd=\Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.article.default");
  $fd->setComponent("field_ebt_task2",["type"=>"entity_reference_browser_table_widget","weight"=>63,"region"=>"content","settings"=>["entity_browser"=>"","field_widget_display"=>"label","field_widget_display_settings"=>[],"field_widget_edit"=>TRUE,"field_widget_remove"=>TRUE,"field_widget_replace"=>FALSE,"selection_mode"=>"selection_append","open"=>FALSE,"additional_fields"=>["options"=>["status"=>0]]]])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: field_ebt_task2 table widget with Status column OFF"
