#!/usr/bin/env bash
# Introspection SETUP: create text_with_summary field field_tso_help on Article and set a
# distinctive text_summary_options summary_help text for the agent to read back. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node","field_tso_help")) {
    FieldStorageConfig::create(["field_name"=>"field_tso_help","entity_type"=>"node","type"=>"text_with_summary"])->save();
  }
  if (!FieldConfig::loadByName("node","article","field_tso_help")) {
    FieldConfig::create(["field_name"=>"field_tso_help","entity_type"=>"node","bundle"=>"article","label"=>"TSO Help Field"])->save();
  }
  $fc = FieldConfig::loadByName("node","article","field_tso_help");
  $fc->setThirdPartySetting("text_summary_options","summary_help","TSO help marker two text");
  $fc->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: field_tso_help has text_summary_options summary_help='TSO help marker two text'"
