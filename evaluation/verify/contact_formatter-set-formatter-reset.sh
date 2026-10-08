#!/usr/bin/env bash
# Execution RESET: ensure an entity_reference(->contact_form) field field_cfmt_task exists on
# Article, displayed with the default label formatter (NOT contact_field_formatter) so verify
# FAILS until the agent switches the formatter. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_cfmt_task")) {
    FieldStorageConfig::create([
      "field_name" => "field_cfmt_task", "entity_type" => "node",
      "type" => "entity_reference", "settings" => ["target_type" => "contact_form"],
    ])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_cfmt_task")) {
    FieldConfig::create(["field_name" => "field_cfmt_task", "entity_type" => "node", "bundle" => "article", "label" => "Task Contact Form"])->save();
  }
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $vd->setComponent("field_cfmt_task", ["type" => "entity_reference_label", "region" => "content", "weight" => 50])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: node.article field_cfmt_task shown with entity_reference_label (not contact_field_formatter)"
