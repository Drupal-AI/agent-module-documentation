#!/usr/bin/env bash
# Introspection SETUP (disable_field): create two string fields on Article — field_df_on
# (disabled on EDIT form for all users) and field_df_add (disabled on ADD form for all users)
# via disable_field third-party settings. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  foreach (["field_df_on","field_df_add"] as $fn) {
    if (!FieldStorageConfig::loadByName("node", $fn)) {
      FieldStorageConfig::create(["field_name"=>$fn,"entity_type"=>"node","type"=>"string"])->save();
    }
    if (!($fc = FieldConfig::loadByName("node","article",$fn))) {
      $fc = FieldConfig::create(["field_name"=>$fn,"entity_type"=>"node","bundle"=>"article","label"=>ucfirst($fn)]);
    }
    if ($fn === "field_df_on") {
      $fc->setThirdPartySetting("disable_field","add_disable","none");
      $fc->setThirdPartySetting("disable_field","edit_disable","all");
    } else {
      $fc->setThirdPartySetting("disable_field","add_disable","all");
      $fc->setThirdPartySetting("disable_field","edit_disable","none");
    }
    $fc->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: field_df_on edit_disable=all; field_df_add add_disable=all"
