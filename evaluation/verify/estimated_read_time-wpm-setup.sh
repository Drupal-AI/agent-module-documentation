#!/usr/bin/env bash
# Introspection SETUP: add an estimated_read_time field field_ert_known to Article configured
# with words_per_minute=300 (view_mode=default), so the agent can read the configured speed.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_ert_known")) {
    FieldStorageConfig::create(["field_name" => "field_ert_known", "entity_type" => "node", "type" => "estimated_read_time"])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_ert_known")) {
    FieldConfig::create(["field_name" => "field_ert_known", "entity_type" => "node", "bundle" => "article", "label" => "Known Read Time"])->save();
  }
  $f = FieldConfig::loadByName("node", "article", "field_ert_known");
  $f->setSetting("words_per_minute", 300);
  $f->setSetting("view_mode", "default");
  $f->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: node.article field_ert_known words_per_minute=300"
