#!/usr/bin/env bash
# Execution RESET: field_fwam_disable exists with add_more TRUE, so verify (passes only when it
# is NOT true) FAILS until the agent turns it off. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node","field_fwam_disable")) {
    FieldStorageConfig::create(["field_name"=>"field_fwam_disable","entity_type"=>"node","type"=>"string","cardinality"=>4])->save();
  }
  if (!FieldConfig::loadByName("node","article","field_fwam_disable")) {
    FieldConfig::create(["field_name"=>"field_fwam_disable","entity_type"=>"node","bundle"=>"article","label"=>"Disable Field"])->save();
  }
  $fd=\Drupal::service("entity_display.repository")->getFormDisplay("node","article","default");
  $fd->setComponent("field_fwam_disable",["type"=>"string_textfield","weight"=>63,"region"=>"content","third_party_settings"=>["field_widget_add_more"=>["add_more"=>TRUE]]])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: field_fwam_disable present with add_more=TRUE"
