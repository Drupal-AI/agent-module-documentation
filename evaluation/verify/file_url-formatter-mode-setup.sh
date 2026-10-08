#!/usr/bin/env bash
# Introspection SETUP: create a file_url field field_fu_fmt on Article and set its
# file_url_default formatter to the "plain" URL mode on the default view display, so an agent
# can read back the display mode. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_fu_fmt")) {
    FieldStorageConfig::create([
      "field_name" => "field_fu_fmt", "entity_type" => "node", "type" => "file_url",
    ])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_fu_fmt")) {
    FieldConfig::create([
      "field_name" => "field_fu_fmt", "entity_type" => "node",
      "bundle" => "article", "label" => "Formatted Attachment",
    ])->save();
  }
  \Drupal::service("entity_display.repository")->getViewDisplay("node","article")
    ->setComponent("field_fu_fmt", ["type" => "file_url_default", "settings" => ["mode" => "plain"]])
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: field_fu_fmt formatter file_url_default mode=plain on node.article default view"
