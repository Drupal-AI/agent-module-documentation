#!/usr/bin/env bash
# Execution RESET for the migrate case: (re)create a PLAIN entity_reference field
# field_mlmm_mig (target media) on Article with a media_library widget, so its storage type is
# 'entity_reference' and verify FAILS until the agent migrates it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  // Drop any prior version so we always start from a clean entity_reference field.
  if ($fc = FieldConfig::loadByName("node", "article", "field_mlmm_mig")) { $fc->delete(); }
  if ($fs = FieldStorageConfig::loadByName("node", "field_mlmm_mig")) { $fs->delete(); }
  drupal_flush_all_caches();
  FieldStorageConfig::create([
    "field_name" => "field_mlmm_mig", "entity_type" => "node",
    "type" => "entity_reference", "settings" => ["target_type" => "media"],
  ])->save();
  FieldConfig::create([
    "field_name" => "field_mlmm_mig", "entity_type" => "node",
    "bundle" => "article", "label" => "Migratable media",
  ])->save();
  $fd = \Drupal::service("entity_display.repository")->getFormDisplay("node", "article", "default");
  $fd->setComponent("field_mlmm_mig", [
    "type" => "media_library_widget", "weight" => 62, "region" => "content",
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: node.article field_mlmm_mig created as plain entity_reference (target media)"
