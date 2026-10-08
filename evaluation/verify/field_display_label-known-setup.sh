#!/usr/bin/env bash
# Introspection SETUP: create a field on Article and give it a known display label via
# field_display_label so the agent can read it back. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_fdl_known")) {
    FieldStorageConfig::create(["field_name" => "field_fdl_known", "entity_type" => "node", "type" => "string"])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_fdl_known")) {
    FieldConfig::create(["field_name" => "field_fdl_known", "entity_type" => "node", "bundle" => "article", "label" => "Known Field"])->save();
  }
  $fc = FieldConfig::loadByName("node", "article", "field_fdl_known");
  $fc->setThirdPartySetting("field_display_label", "display_label", "FDL Known Display")->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: node.article field_fdl_known display_label=FDL Known Display"
