#!/usr/bin/env bash
# Introspection SETUP: add a string field field_rop_known to Article and flag it required-on-publish
# via the require_on_publish third-party setting, so an agent can read back which field is flagged.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_rop_known")) {
    FieldStorageConfig::create(["field_name" => "field_rop_known", "entity_type" => "node", "type" => "string"])->save();
  }
  $fc = FieldConfig::loadByName("node", "article", "field_rop_known") ?: FieldConfig::create(["field_name" => "field_rop_known", "entity_type" => "node", "bundle" => "article", "label" => "Known ROP"]);
  $fc->setThirdPartySetting("require_on_publish", "require_on_publish", TRUE);
  $fc->save();
' >/dev/null 2>&1
echo "setup: node.article field_rop_known flagged require_on_publish=true"
