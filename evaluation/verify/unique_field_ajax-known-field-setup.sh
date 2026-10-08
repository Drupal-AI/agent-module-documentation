#!/usr/bin/env bash
# Introspection SETUP: create a string field field_ufa_known on Article and mark it unique via
# unique_field_ajax third-party settings, so an inspecting agent can read back which field is
# unique. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_ufa_known")) {
    FieldStorageConfig::create([
      "field_name" => "field_ufa_known", "entity_type" => "node",
      "type" => "string", "cardinality" => 1,
    ])->save();
  }
  $fc = FieldConfig::loadByName("node", "article", "field_ufa_known");
  if (!$fc) {
    $fc = FieldConfig::create([
      "field_name" => "field_ufa_known", "entity_type" => "node",
      "bundle" => "article", "label" => "Known Unique Code",
    ]);
  }
  $fc->setThirdPartySetting("unique_field_ajax", "unique", 1);
  $fc->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: node.article field_ufa_known has unique_field_ajax.unique=1"
