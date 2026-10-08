#!/usr/bin/env bash
# Introspection SETUP: add a Date/time field field_dtn_known to Article with the
# datetime_default widget, so an inspecting agent can identify which field will render the
# datetime_now "Now" button. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_dtn_known")) {
    FieldStorageConfig::create([
      "field_name" => "field_dtn_known", "entity_type" => "node",
      "type" => "datetime", "settings" => ["datetime_type" => "datetime"],
    ])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_dtn_known")) {
    FieldConfig::create([
      "field_name" => "field_dtn_known", "entity_type" => "node",
      "bundle" => "article", "label" => "Known Moment",
    ])->save();
  }
  $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.article.default");
  $fd->setComponent("field_dtn_known", ["type" => "datetime_default", "weight" => 90, "region" => "content"])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: node.article field_dtn_known (datetime_default) present"
