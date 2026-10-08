#!/usr/bin/env bash
# Execution RESET: ensure an entity_reference(->contact_form) field field_cfmt_page exists on
# the Basic page content type, displayed with the plain label formatter so verify FAILS until
# the agent makes the referenced contact form render as an actual form. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_cfmt_page")) {
    FieldStorageConfig::create([
      "field_name" => "field_cfmt_page", "entity_type" => "node",
      "type" => "entity_reference", "settings" => ["target_type" => "contact_form"],
    ])->save();
  }
  if (!FieldConfig::loadByName("node", "page", "field_cfmt_page")) {
    FieldConfig::create(["field_name" => "field_cfmt_page", "entity_type" => "node", "bundle" => "page", "label" => "Contact form"])->save();
  }
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.page.default");
  $vd->setComponent("field_cfmt_page", ["type" => "entity_reference_label", "region" => "content", "weight" => 50])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: node.page field_cfmt_page shown with entity_reference_label"
