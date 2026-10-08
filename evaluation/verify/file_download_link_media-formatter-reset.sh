#!/usr/bin/env bash
# Execution RESET: create a Media reference field on Article displayed with the core
# entity_reference_label formatter, so verify fails until switched to file_download_link_media.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_fdlm_task")) {
    FieldStorageConfig::create(["field_name" => "field_fdlm_task", "entity_type" => "node", "type" => "entity_reference", "settings" => ["target_type" => "media"]])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_fdlm_task")) {
    FieldConfig::create(["field_name" => "field_fdlm_task", "entity_type" => "node", "bundle" => "article", "label" => "FDLM Task", "settings" => ["handler" => "default:media", "handler_settings" => []]])->save();
  }
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $vd->setComponent("field_fdlm_task", ["type" => "entity_reference_label", "label" => "above", "weight" => 60, "region" => "content", "settings" => ["link" => true]])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: node.article field_fdlm_task uses core entity_reference_label formatter"
