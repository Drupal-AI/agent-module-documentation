#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("user", "field_sfa_known")) {
    FieldStorageConfig::create(["field_name" => "field_sfa_known", "entity_type" => "user", "type" => "address"])->save();
  }
  if (!FieldConfig::loadByName("user", "user", "field_sfa_known")) {
    FieldConfig::create(["field_name" => "field_sfa_known", "entity_type" => "user", "bundle" => "user", "label" => "Addr"])->save();
  }
  $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("user.user.default");
  $fd->setComponent("field_sfa_known", ["type" => "salesforce_ready_address", "region" => "content"])->save();
' >/dev/null 2>&1
echo "setup: user.field_sfa_known (address) widget=salesforce_ready_address"
