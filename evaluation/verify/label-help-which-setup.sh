#!/usr/bin/env bash
# Introspection SETUP: add field_lh_on (with Label Help) and field_lh_off (without) to Article,
# so an agent must inspect which one carries the label_help third-party setting. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  foreach (["field_lh_on", "field_lh_off"] as $fn) {
    if (!FieldStorageConfig::loadByName("node", $fn)) {
      FieldStorageConfig::create(["field_name" => $fn, "entity_type" => "node", "type" => "string"])->save();
    }
    if (!FieldConfig::loadByName("node", "article", $fn)) {
      FieldConfig::create(["field_name" => $fn, "entity_type" => "node", "bundle" => "article", "label" => strtoupper($fn)])->save();
    }
  }
  $on = FieldConfig::loadByName("node", "article", "field_lh_on");
  $on->setThirdPartySetting("label_help", "label_help_description", "This field has a helpful hint.");
  $on->save();
  // Ensure field_lh_off has no label help.
  $off = FieldConfig::loadByName("node", "article", "field_lh_off");
  $off->unsetThirdPartySetting("label_help", "label_help_description");
  $off->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: field_lh_on (has label help) and field_lh_off (none) on node.article"
