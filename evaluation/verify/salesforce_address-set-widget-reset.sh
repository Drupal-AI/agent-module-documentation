#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("user", "field_sfa_task")) {
    FieldStorageConfig::create(["field_name" => "field_sfa_task", "entity_type" => "user", "type" => "address"])->save();
  }
  if (!FieldConfig::loadByName("user", "user", "field_sfa_task")) {
    FieldConfig::create(["field_name" => "field_sfa_task", "entity_type" => "user", "bundle" => "user", "label" => "Addr"])->save();
  }
  $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("user.user.default");
  $fd->setComponent("field_sfa_task", ["type" => "address_default", "region" => "content"])->save();
' >/dev/null 2>&1
echo "reset: field_sfa_task widget=address_default"
