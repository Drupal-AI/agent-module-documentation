#!/usr/bin/env bash
# HARD execution reset for the "enable the YAML editor widget on a field" task.
# Ensures a string_long field `field_yaml_config` exists on the Article content type and
# sets its Manage-form-display widget to the PLAIN core textarea (`string_textarea`), so the
# yaml_editor widget is NOT yet in use (verify must FAIL right after this runs).
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_yaml_config")) {
    FieldStorageConfig::create(["field_name" => "field_yaml_config", "entity_type" => "node", "type" => "string_long"])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_yaml_config")) {
    FieldConfig::create(["field_name" => "field_yaml_config", "entity_type" => "node", "bundle" => "article", "label" => "YAML config"])->save();
  }
  $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.article.default");
  $fd->setComponent("field_yaml_config", ["type" => "string_textarea", "weight" => 50])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: node.article.field_yaml_config widget set to plain string_textarea"
