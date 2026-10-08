#!/usr/bin/env bash
# Introspection SETUP: create a long-text field on Article and use better_formats to allow
# ONLY the basic_html format, so an agent can read back which format is allowed. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_bf_med")) {
    FieldStorageConfig::create(["field_name" => "field_bf_med", "entity_type" => "node", "type" => "text_long"])->save();
  }
  $fc = FieldConfig::loadByName("node", "article", "field_bf_med");
  if (!$fc) {
    $fc = FieldConfig::create(["field_name" => "field_bf_med", "entity_type" => "node", "bundle" => "article", "label" => "BF Medium Text"]);
  }
  $fc->setThirdPartySetting("better_formats", "allowed_formats_toggle", TRUE);
  $fc->setThirdPartySetting("better_formats", "allowed_formats", ["basic_html" => "basic_html"]);
  $fc->save();
' >/dev/null 2>&1
echo "setup: node.article field_bf_med allows only basic_html (better_formats)"
