#!/usr/bin/env bash
# Execution RESET: ensure field_tso_ph (text_with_summary) exists on Article with NO
# text_summary_options summary_placeholder, so verify FAILS until the agent adds one.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node","field_tso_ph")) {
    FieldStorageConfig::create(["field_name"=>"field_tso_ph","entity_type"=>"node","type"=>"text_with_summary"])->save();
  }
  if (!FieldConfig::loadByName("node","article","field_tso_ph")) {
    FieldConfig::create(["field_name"=>"field_tso_ph","entity_type"=>"node","bundle"=>"article","label"=>"TSO Placeholder Field"])->save();
  }
  $fc = FieldConfig::loadByName("node","article","field_tso_ph");
  $fc->unsetThirdPartySetting("text_summary_options","summary_placeholder");
  $fc->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: field_tso_ph present, text_summary_options summary_placeholder unset"
