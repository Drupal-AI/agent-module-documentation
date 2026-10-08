#!/usr/bin/env bash
# Introspection SETUP: enable submodule; create multi-value list_string field field_imsw_known on
# Article with the ims_options_select widget on the default form display. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush en ims_options_widget -y >/dev/null 2>&1
drush php:eval '  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_imsw_known")) {
    FieldStorageConfig::create(["field_name" => "field_imsw_known", "entity_type" => "node", "type" => "list_string", "cardinality" => -1, "settings" => ["allowed_values" => ["a" => "A", "b" => "B", "c" => "C"]]])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_imsw_known")) {
    FieldConfig::create(["field_name" => "field_imsw_known", "entity_type" => "node", "bundle" => "article", "label" => "Known Tags"])->save();
  }
  $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.article.default");
  $fd->setComponent("field_imsw_known", ["type" => "ims_options_select", "weight" => 70, "region" => "content"])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: node.article field_imsw_known uses ims_options_select"
