#!/usr/bin/env bash
# Introspection SETUP: field_ebt_stat on Article uses the table widget WITH the Status column
# enabled (additional_fields.options.status). Agent reports which field has the Status column.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node","field_ebt_stat")) {
    FieldStorageConfig::create(["field_name"=>"field_ebt_stat","entity_type"=>"node","type"=>"entity_reference","cardinality"=>-1,"settings"=>["target_type"=>"node"]])->save();
  }
  if (!FieldConfig::loadByName("node","article","field_ebt_stat")) {
    FieldConfig::create(["field_name"=>"field_ebt_stat","entity_type"=>"node","bundle"=>"article","label"=>"EBT Stat","settings"=>["handler"=>"default:node"]])->save();
  }
  $fd=\Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.article.default");
  $fd->setComponent("field_ebt_stat",["type"=>"entity_reference_browser_table_widget","weight"=>62,"region"=>"content","settings"=>["entity_browser"=>"","field_widget_display"=>"label","field_widget_display_settings"=>[],"field_widget_edit"=>TRUE,"field_widget_remove"=>TRUE,"field_widget_replace"=>FALSE,"selection_mode"=>"selection_append","open"=>FALSE,"additional_fields"=>["options"=>["status"=>"status"]]]])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: field_ebt_stat table widget with Status column enabled"
