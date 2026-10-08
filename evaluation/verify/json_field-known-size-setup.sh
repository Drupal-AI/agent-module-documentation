#!/usr/bin/env bash
# Introspection SETUP: create a JSON (text) field field_jf_known on Article with the
# non-default storage setting size = 65535 ("16 KB / text normal") so the agent can read the
# value back from field.storage.node.field_jf_known. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_jf_known")) {
    FieldStorageConfig::create([
      "field_name" => "field_jf_known", "entity_type" => "node",
      "type" => "json", "settings" => ["size" => 65535],
    ])->save();
  }
  else {
    $fs = FieldStorageConfig::loadByName("node", "field_jf_known");
    $fs->setSetting("size", 65535)->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_jf_known")) {
    FieldConfig::create([
      "field_name" => "field_jf_known", "entity_type" => "node",
      "bundle" => "article", "label" => "Known Payload",
    ])->save();
  }
  $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.article.default");
  $fd->setComponent("field_jf_known", ["type" => "json_textarea", "weight" => 60, "region" => "content"])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: node.article field_jf_known (type json) size=65535"
