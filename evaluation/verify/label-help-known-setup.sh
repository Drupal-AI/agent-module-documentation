#!/usr/bin/env bash
# Introspection SETUP: add field_lh_known to Article and store a known Label Help message on it
# (third_party_settings.label_help.label_help_description) so an agent can read it back. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_lh_known")) {
    FieldStorageConfig::create([
      "field_name" => "field_lh_known", "entity_type" => "node", "type" => "string",
    ])->save();
  }
  $fc = FieldConfig::loadByName("node", "article", "field_lh_known");
  if (!$fc) {
    $fc = FieldConfig::create([
      "field_name" => "field_lh_known", "entity_type" => "node",
      "bundle" => "article", "label" => "LH Known",
    ]);
  }
  $fc->setThirdPartySetting("label_help", "label_help_description", "Known helper text for this field.");
  $fc->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: field_lh_known on node.article with label_help = 'Known helper text for this field.'"
