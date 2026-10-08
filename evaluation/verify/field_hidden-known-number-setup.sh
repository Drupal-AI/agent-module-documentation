#!/usr/bin/env bash
# Introspection SETUP: create an integer field field_fh_count on Article using the Field Hidden
# number widget (field_hidden_number), so an agent can read back its widget id. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_fh_count")) {
    FieldStorageConfig::create(["field_name" => "field_fh_count", "entity_type" => "node", "type" => "integer"])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_fh_count")) {
    FieldConfig::create(["field_name" => "field_fh_count", "entity_type" => "node", "bundle" => "article", "label" => "Hidden Count"])->save();
  }
  $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.article.default");
  $fd->setComponent("field_fh_count", ["type" => "field_hidden_number", "weight" => 51, "region" => "content"])->save();
' >/dev/null 2>&1
echo "setup: node.article field_fh_count uses widget field_hidden_number"
