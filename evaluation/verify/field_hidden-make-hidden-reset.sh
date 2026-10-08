#!/usr/bin/env bash
# Execution RESET: ensure a string field field_fh_token exists on Article with a NON-hidden
# widget (core string_textfield) on the default form display, so verify FAILS until the agent
# switches it to the Field Hidden widget. Creates the field if missing. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_fh_token")) {
    FieldStorageConfig::create(["field_name" => "field_fh_token", "entity_type" => "node", "type" => "string"])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_fh_token")) {
    FieldConfig::create(["field_name" => "field_fh_token", "entity_type" => "node", "bundle" => "article", "label" => "Token"])->save();
  }
  $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.article.default");
  $fd->setComponent("field_fh_token", ["type" => "string_textfield", "weight" => 52, "region" => "content"])->save();
' >/dev/null 2>&1
echo "reset: node.article field_fh_token present with widget string_textfield (NOT hidden)"
