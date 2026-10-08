#!/usr/bin/env bash
# Execution RESET: ensure field_fl_target exists on Article and is placed on the default view
# display with NO field_label third-party settings, so verify FAILS until the agent sets the
# wrapper tag. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_fl_target")) {
    FieldStorageConfig::create(["field_name" => "field_fl_target", "entity_type" => "node", "type" => "string"])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_fl_target")) {
    FieldConfig::create(["field_name" => "field_fl_target", "entity_type" => "node", "bundle" => "article", "label" => "FL Target"])->save();
  }
  $d = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $d->setComponent("field_fl_target", ["type" => "string", "weight" => 50, "region" => "content", "label" => "above"])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: node.article.default field_fl_target present with no field_label wrapper tag"
