#!/usr/bin/env bash
# Execution RESET: content type stv_content with single-value string field field_stv_task using
# the PLAIN core string_textfield widget (NOT a Select Text Value widget), so verify FAILS until
# the agent switches the widget. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\NodeType;
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!NodeType::load("stv_content")) { NodeType::create(["type" => "stv_content", "name" => "STV Content"])->save(); }
  if (!FieldStorageConfig::loadByName("node", "field_stv_task")) {
    FieldStorageConfig::create(["field_name" => "field_stv_task", "entity_type" => "node", "type" => "string"])->save();
  }
  if (!FieldConfig::loadByName("node", "stv_content", "field_stv_task")) {
    FieldConfig::create(["field_name" => "field_stv_task", "entity_type" => "node", "bundle" => "stv_content", "label" => "Task Colour"])->save();
  }
  $fd = \Drupal::service("entity_display.repository")->getFormDisplay("node", "stv_content", "default");
  $fd->setComponent("field_stv_task", ["type" => "string_textfield", "weight" => 50, "region" => "content", "settings" => []])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: node.stv_content field_stv_task uses plain string_textfield"
