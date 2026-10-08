#!/usr/bin/env bash
# Introspection SETUP: build three content types that look like the result of an Entity Type
# Clone session — etc_known_src (source, has field_etc_known AND field_etc_extra),
# etc_known_a (only field_etc_known) and etc_known_b (both fields, i.e. the full clone).
# The agent must inspect the live site's field configuration to say which one is the complete
# clone. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\NodeType;
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  foreach ([
    "etc_known_src" => "ETC Known Source",
    "etc_known_a"   => "ETC Known A",
    "etc_known_b"   => "ETC Known B",
  ] as $id => $label) {
    if (!NodeType::load($id)) {
      NodeType::create(["type" => $id, "name" => $label])->save();
    }
  }
  foreach (["field_etc_known", "field_etc_extra"] as $fn) {
    if (!FieldStorageConfig::loadByName("node", $fn)) {
      FieldStorageConfig::create(["field_name" => $fn, "entity_type" => "node", "type" => "string"])->save();
    }
  }
  $map = [
    "etc_known_src" => ["field_etc_known", "field_etc_extra"],
    "etc_known_a"   => ["field_etc_known"],
    "etc_known_b"   => ["field_etc_known", "field_etc_extra"],
  ];
  foreach ($map as $bundle => $fields) {
    foreach ($fields as $fn) {
      if (!FieldConfig::loadByName("node", $bundle, $fn)) {
        FieldConfig::create([
          "field_name" => $fn, "entity_type" => "node", "bundle" => $bundle,
          "label" => ucfirst(str_replace("field_etc_", "ETC ", $fn)),
        ])->save();
      }
    }
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: etc_known_src(field_etc_known,field_etc_extra) etc_known_a(field_etc_known) etc_known_b(both)"
