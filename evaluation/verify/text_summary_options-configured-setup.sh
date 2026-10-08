#!/usr/bin/env bash
# Introspection SETUP: create a text_with_summary field field_tso_sum on Article and set
# text_summary_options show_summary=1 + a distinctive summary placeholder, so an inspecting
# agent can read back the configuration from the field config. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node","field_tso_sum")) {
    FieldStorageConfig::create(["field_name"=>"field_tso_sum","entity_type"=>"node","type"=>"text_with_summary"])->save();
  }
  if (!FieldConfig::loadByName("node","article","field_tso_sum")) {
    FieldConfig::create(["field_name"=>"field_tso_sum","entity_type"=>"node","bundle"=>"article","label"=>"TSO Summary Field"])->save();
  }
  $fc = FieldConfig::loadByName("node","article","field_tso_sum");
  $fc->setThirdPartySetting("text_summary_options","show_summary",TRUE);
  $fc->setThirdPartySetting("text_summary_options","summary_placeholder","TSO placeholder marker one");
  $fc->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: field_tso_sum has text_summary_options show_summary=1, placeholder='TSO placeholder marker one'"
