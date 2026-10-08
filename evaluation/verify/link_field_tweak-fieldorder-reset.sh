#!/usr/bin/env bash
# Execution RESET: ensure link field field_lft_task exists on Article with a link_default widget
# and force link_field_tweak link_default_field_order OFF, so verify FAILS until the agent
# switches the field order on. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_lft_task")) {
    FieldStorageConfig::create(["field_name" => "field_lft_task", "entity_type" => "node", "type" => "link"])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_lft_task")) {
    FieldConfig::create(["field_name" => "field_lft_task", "entity_type" => "node", "bundle" => "article", "label" => "Task Link"])->save();
  }
  $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.article.default");
  $fd->setComponent("field_lft_task", [
    "type" => "link_default", "weight" => 60, "region" => "content",
    "third_party_settings" => ["link_field_tweak" => ["link_default_field_order" => FALSE]],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: field_lft_task link_default widget link_default_field_order=FALSE"
