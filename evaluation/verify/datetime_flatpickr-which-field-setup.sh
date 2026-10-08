#!/usr/bin/env bash
# Introspection SETUP: field_dtf_fp (datetime_flatpickr) + field_dtf_plain (datetime_default). Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  foreach (["field_dtf_fp"=>"DTF FP","field_dtf_plain"=>"DTF Plain"] as $fn=>$lbl) {
    if (!FieldStorageConfig::loadByName("node",$fn)) { FieldStorageConfig::create(["field_name"=>$fn,"entity_type"=>"node","type"=>"datetime","settings"=>["datetime_type"=>"datetime"]])->save(); }
    if (!FieldConfig::loadByName("node","article",$fn)) { FieldConfig::create(["field_name"=>$fn,"entity_type"=>"node","bundle"=>"article","label"=>$lbl])->save(); }
  }
  $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.article.default");
  $fd->setComponent("field_dtf_fp", ["type"=>"datetime_flatpickr","weight"=>50,"region"=>"content","settings"=>[]])->save();
  $fd->setComponent("field_dtf_plain", ["type"=>"datetime_default","weight"=>51,"region"=>"content","settings"=>[]])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: field_dtf_fp=flatpickr, field_dtf_plain=default"
