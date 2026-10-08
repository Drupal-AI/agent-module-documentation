#!/usr/bin/env bash
# Execution RESET: ensure field_tso_show (text_with_summary) exists on Article with the
# text_summary_options show_summary setting OFF, so verify FAILS until the agent turns it on.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node","field_tso_show")) {
    FieldStorageConfig::create(["field_name"=>"field_tso_show","entity_type"=>"node","type"=>"text_with_summary"])->save();
  }
  if (!FieldConfig::loadByName("node","article","field_tso_show")) {
    FieldConfig::create(["field_name"=>"field_tso_show","entity_type"=>"node","bundle"=>"article","label"=>"TSO Show Field"])->save();
  }
  $fc = FieldConfig::loadByName("node","article","field_tso_show");
  $fc->unsetThirdPartySetting("text_summary_options","show_summary");
  $fc->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: field_tso_show present, text_summary_options show_summary unset"
