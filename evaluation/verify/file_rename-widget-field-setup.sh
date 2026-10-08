#!/usr/bin/env bash
# Introspection SETUP: create a file field field_fr_doc on Article and enable the file_rename
# per-widget "Show rename link" (third_party_settings.file_rename.show_rename_link=TRUE) on its
# widget in the default form display. Also force the global flag OFF so the per-widget opt-in is
# the only thing enabling the link. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush config:set file_rename.settings always_show_widget_link 0 -y >/dev/null 2>&1
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_fr_doc")) {
    FieldStorageConfig::create([
      "field_name" => "field_fr_doc", "entity_type" => "node",
      "type" => "file", "cardinality" => 1,
    ])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_fr_doc")) {
    FieldConfig::create([
      "field_name" => "field_fr_doc", "entity_type" => "node",
      "bundle" => "article", "label" => "Attached Document",
    ])->save();
  }
  $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.article.default");
  $fd->setComponent("field_fr_doc", [
    "type" => "file_generic", "weight" => 60, "region" => "content",
    "third_party_settings" => ["file_rename" => ["show_rename_link" => TRUE]],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: node.article field_fr_doc (file_generic) has file_rename.show_rename_link=TRUE"
