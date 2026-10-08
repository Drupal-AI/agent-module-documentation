#!/usr/bin/env bash
# Execution RESET (disable_field): ensure string field field_df_task on Article with
# disable_field NOT disabling anything (add_disable=none, edit_disable=none). So both verify
# scripts FAIL until the agent configures it. Uses the pre-existing content_editor role for the
# roles-based case (does not create roles). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node","field_df_task")) {
    FieldStorageConfig::create(["field_name"=>"field_df_task","entity_type"=>"node","type"=>"string"])->save();
  }
  if (!($fc = FieldConfig::loadByName("node","article","field_df_task"))) {
    $fc = FieldConfig::create(["field_name"=>"field_df_task","entity_type"=>"node","bundle"=>"article","label"=>"Task Field"]);
  }
  $fc->setThirdPartySetting("disable_field","add_disable","none");
  $fc->setThirdPartySetting("disable_field","edit_disable","none");
  $fc->unsetThirdPartySetting("disable_field","add_roles");
  $fc->unsetThirdPartySetting("disable_field","edit_roles");
  $fc->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: field_df_task add_disable=none edit_disable=none"
