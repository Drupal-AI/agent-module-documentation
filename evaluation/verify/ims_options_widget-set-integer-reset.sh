#!/usr/bin/env bash
# Execution RESET: enable submodule; ensure list_integer field field_imsw_pri on Article uses core
# options_select so verify FAILS until agent switches it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush en ims_options_widget -y >/dev/null 2>&1
drush php:eval '  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_imsw_pri")) {
    FieldStorageConfig::create(["field_name" => "field_imsw_pri", "entity_type" => "node", "type" => "list_integer", "cardinality" => -1, "settings" => ["allowed_values" => [1 => "One", 2 => "Two", 3 => "Three"]]])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_imsw_pri")) {
    FieldConfig::create(["field_name" => "field_imsw_pri", "entity_type" => "node", "bundle" => "article", "label" => "Priorities"])->save();
  }
  $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.article.default");
  $fd->setComponent("field_imsw_pri", ["type" => "options_select", "weight" => 74, "region" => "content"])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: field_imsw_pri uses options_select"
