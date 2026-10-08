#!/usr/bin/env bash
# Introspection SETUP: create a FILE field field_insert_known on Article with a file_generic
# widget and enable Insert on it (styles: "Link to file" + AUTOMATIC, default = link), so an
# inspecting agent can read back which field/widget has the third_party_settings.insert. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_insert_known")) {
    FieldStorageConfig::create(["field_name" => "field_insert_known", "entity_type" => "node", "type" => "file"])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_insert_known")) {
    FieldConfig::create(["field_name" => "field_insert_known", "entity_type" => "node", "bundle" => "article", "label" => "Known Attachment"])->save();
  }
  $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.article.default");
  $fd->setComponent("field_insert_known", [
    "type" => "file_generic", "weight" => 60, "region" => "content",
    "third_party_settings" => ["insert" => ["styles" => ["link" => "link", "insert__auto" => "insert__auto"], "default" => "link", "auto_image_style" => "image", "link_image" => NULL, "width" => "", "rotate" => FALSE]],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: node.article field_insert_known (file_generic) has third_party_settings.insert (styles link, default link)"
