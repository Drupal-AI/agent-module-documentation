#!/usr/bin/env bash
# Introspection SETUP: create a string field field_fh_secret on Article and set its default
# form-display widget to the Field Hidden widget (field_hidden_string_textfield), so an
# inspecting agent can read back which field uses a hidden-input widget. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_fh_secret")) {
    FieldStorageConfig::create(["field_name" => "field_fh_secret", "entity_type" => "node", "type" => "string"])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_fh_secret")) {
    FieldConfig::create(["field_name" => "field_fh_secret", "entity_type" => "node", "bundle" => "article", "label" => "Secret Code"])->save();
  }
  $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.article.default");
  $fd->setComponent("field_fh_secret", ["type" => "field_hidden_string_textfield", "weight" => 50, "region" => "content"])->save();
' >/dev/null 2>&1
echo "setup: node.article field_fh_secret uses widget field_hidden_string_textfield"
