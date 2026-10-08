#!/usr/bin/env bash
# Introspection SETUP: add a string field field_rop_warn to Article flagged require_on_publish AND
# warn_on_empty, so an agent can read back which field also warns on empty for drafts. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_rop_warn")) {
    FieldStorageConfig::create(["field_name" => "field_rop_warn", "entity_type" => "node", "type" => "string"])->save();
  }
  $fc = FieldConfig::loadByName("node", "article", "field_rop_warn") ?: FieldConfig::create(["field_name" => "field_rop_warn", "entity_type" => "node", "bundle" => "article", "label" => "Warn ROP"]);
  $fc->setThirdPartySetting("require_on_publish", "require_on_publish", TRUE);
  $fc->setThirdPartySetting("require_on_publish", "warn_on_empty", TRUE);
  $fc->save();
' >/dev/null 2>&1
echo "setup: field_rop_warn has require_on_publish + warn_on_empty = true"
