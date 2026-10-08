#!/usr/bin/env bash
# Introspection SETUP: two capped fields on Article - field_fwam_on (add_more TRUE) and
# field_fwam_no (add_more not set). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  foreach (["field_fwam_on","field_fwam_no"] as $fn) {
    if (!FieldStorageConfig::loadByName("node",$fn)) {
      FieldStorageConfig::create(["field_name"=>$fn,"entity_type"=>"node","type"=>"string","cardinality"=>4])->save();
    }
    if (!FieldConfig::loadByName("node","article",$fn)) {
      FieldConfig::create(["field_name"=>$fn,"entity_type"=>"node","bundle"=>"article","label"=>strtoupper($fn)])->save();
    }
  }
  $fd=\Drupal::service("entity_display.repository")->getFormDisplay("node","article","default");
  $fd->setComponent("field_fwam_on",["type"=>"string_textfield","weight"=>61,"region"=>"content","third_party_settings"=>["field_widget_add_more"=>["add_more"=>TRUE]]]);
  $fd->setComponent("field_fwam_no",["type"=>"string_textfield","weight"=>62,"region"=>"content","third_party_settings"=>[]]);
  $fd->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: field_fwam_on add_more=true, field_fwam_no no setting"
