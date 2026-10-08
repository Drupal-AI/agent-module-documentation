#!/usr/bin/env bash
# Introspection SETUP: create a duration field field_df_known on Article whose granularity
# collects only hours and minutes (h:i), so an agent can read the granularity back. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_df_known")) {
    FieldStorageConfig::create(["field_name" => "field_df_known", "entity_type" => "node", "type" => "duration"])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_df_known")) {
    FieldConfig::create(["field_name" => "field_df_known", "entity_type" => "node", "bundle" => "article", "label" => "Known Duration", "settings" => ["granularity" => "h:i", "include_weeks" => FALSE]])->save();
  } else {
    $fc = FieldConfig::loadByName("node", "article", "field_df_known"); $fc->setSetting("granularity", "h:i")->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: node.article field_df_known (duration) granularity=h:i"
