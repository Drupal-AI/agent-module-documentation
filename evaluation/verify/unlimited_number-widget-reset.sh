#!/usr/bin/env bash
# HARD (execution) reset for unlimited_number.
# Establishes a clean, KNOWN-WRONG baseline so the verify FAILs until the agent does the
# work: ensures an integer field `field_un_cardinality` exists on the Article content type
# and forces its edit-form widget back to core's plain `number` widget (NOT the module's
# `unlimited_number` widget). The agent's task is to switch that widget to "Unlimited or
# Number" and store "unlimited" as -1.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_un_cardinality")) {
    FieldStorageConfig::create(["field_name" => "field_un_cardinality", "entity_type" => "node", "type" => "integer"])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_un_cardinality")) {
    FieldConfig::create(["field_name" => "field_un_cardinality", "entity_type" => "node", "bundle" => "article", "label" => "Max values"])->save();
  }
  // Force baseline to the core number widget (verify must FAIL from here).
  $fd = \Drupal::service("entity_display.repository")->getFormDisplay("node", "article", "default");
  $fd->setComponent("field_un_cardinality", ["type" => "number", "settings" => []])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: field_un_cardinality on Article set to core number widget (baseline; verify FAILs here)"
