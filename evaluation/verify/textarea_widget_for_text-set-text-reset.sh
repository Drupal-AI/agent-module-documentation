#!/usr/bin/env bash
# Execution RESET: ensure formatted text field field_taw_body on Article uses the single-line
# text_textfield widget so verify FAILS until the agent switches it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_taw_body")) {
    FieldStorageConfig::create(["field_name" => "field_taw_body", "entity_type" => "node", "type" => "text"])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_taw_body")) {
    FieldConfig::create(["field_name" => "field_taw_body", "entity_type" => "node", "bundle" => "article", "label" => "Body Line"])->save();
  }
  $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.article.default");
  $fd->setComponent("field_taw_body", ["type" => "text_textfield", "weight" => 63, "region" => "content", "settings" => []])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: field_taw_body uses text_textfield"
