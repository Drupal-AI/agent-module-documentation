#!/usr/bin/env bash
# Introspection SETUP: create a duration field field_df_disp on Article and configure its
# DEFAULT view display to use the ISO-8601 'Duration String' formatter, so an agent can read
# which formatter is configured. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_df_disp")) {
    FieldStorageConfig::create(["field_name" => "field_df_disp", "entity_type" => "node", "type" => "duration"])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_df_disp")) {
    FieldConfig::create(["field_name" => "field_df_disp", "entity_type" => "node", "bundle" => "article", "label" => "Displayed Duration"])->save();
  }
  \Drupal::service("entity_display.repository")->getViewDisplay("node", "article")
    ->setComponent("field_df_disp", ["type" => "duration_string_display", "weight" => 50, "region" => "content"])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: node.article field_df_disp default view formatter=duration_string_display"
