#!/usr/bin/env bash
# Introspection SETUP: create a dedicated string field field_fl_target on Article, place it on
# the default view display, and give it a field_label label override ('FL Known Label') so an
# inspecting agent can read it back. Self-contained (does not rely on body). Idempotent. Exit 0.
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
  $d->setComponent("field_fl_target", [
    "type" => "string", "weight" => 50, "region" => "content", "label" => "above",
    "third_party_settings" => ["field_label" => ["label_value" => "FL Known Label"]],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: node.article.default field_fl_target has field_label.label_value='FL Known Label'"
