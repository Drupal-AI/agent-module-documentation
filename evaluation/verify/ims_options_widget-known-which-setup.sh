#!/usr/bin/env bash
# Introspection SETUP: enable submodule; create field_imsw_a (ims_options_select) and field_imsw_b
# (core options_select) as multi-value list_string fields on Article. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush en ims_options_widget -y >/dev/null 2>&1
drush php:eval '  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_imsw_a")) {
    FieldStorageConfig::create(["field_name" => "field_imsw_a", "entity_type" => "node", "type" => "list_string", "cardinality" => -1, "settings" => ["allowed_values" => ["a" => "A", "b" => "B", "c" => "C"]]])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_imsw_a")) {
    FieldConfig::create(["field_name" => "field_imsw_a", "entity_type" => "node", "bundle" => "article", "label" => "IMS A"])->save();
  }  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_imsw_b")) {
    FieldStorageConfig::create(["field_name" => "field_imsw_b", "entity_type" => "node", "type" => "list_string", "cardinality" => -1, "settings" => ["allowed_values" => ["a" => "A", "b" => "B", "c" => "C"]]])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_imsw_b")) {
    FieldConfig::create(["field_name" => "field_imsw_b", "entity_type" => "node", "bundle" => "article", "label" => "Core B"])->save();
  }
  $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.article.default");
  $fd->setComponent("field_imsw_a", ["type" => "ims_options_select", "weight" => 71, "region" => "content"])->save();
  $fd->setComponent("field_imsw_b", ["type" => "options_select", "weight" => 72, "region" => "content"])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: field_imsw_a=ims_options_select field_imsw_b=options_select"
