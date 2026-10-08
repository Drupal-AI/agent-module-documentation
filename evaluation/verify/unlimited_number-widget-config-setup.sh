#!/usr/bin/env bash
# MEDIUM (introspection) setup for unlimited_number.
# Plants a KNOWN configuration to read back: an integer field `field_un_limit` on the
# Article content type whose edit-form widget is the module's "Unlimited or Number"
# widget (type `unlimited_number`), configured with the distinctive settings
# label_unlimited="Forever" and value_unlimited=-1. The agent must inspect the live
# entity_form_display (not recite docs — the defaults are "Unlimited" / 0) to answer.
# The paired cleanup script removes it and restores baseline.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_un_limit")) {
    FieldStorageConfig::create(["field_name" => "field_un_limit", "entity_type" => "node", "type" => "integer"])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_un_limit")) {
    FieldConfig::create(["field_name" => "field_un_limit", "entity_type" => "node", "bundle" => "article", "label" => "Item limit"])->save();
  }
  $fd = \Drupal::service("entity_display.repository")->getFormDisplay("node", "article", "default");
  $fd->setComponent("field_un_limit", [
    "type" => "unlimited_number",
    "settings" => ["value_unlimited" => -1, "label_unlimited" => "Forever", "label_number" => "Limited"],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: article integer field field_un_limit uses the unlimited_number widget (label_unlimited=Forever, value_unlimited=-1)"
