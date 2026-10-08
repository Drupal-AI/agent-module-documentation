#!/usr/bin/env bash
# Execution RESET: ensure string field field_taw_task on Article uses the single-line
# string_textfield widget so verify FAILS until the agent switches it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_taw_task")) {
    FieldStorageConfig::create(["field_name" => "field_taw_task", "entity_type" => "node", "type" => "string"])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_taw_task")) {
    FieldConfig::create(["field_name" => "field_taw_task", "entity_type" => "node", "bundle" => "article", "label" => "Task Notes"])->save();
  }
  $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.article.default");
  $fd->setComponent("field_taw_task", ["type" => "string_textfield", "weight" => 62, "region" => "content", "settings" => []])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: field_taw_task uses string_textfield"
