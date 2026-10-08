#!/usr/bin/env bash
# Execution RESET: ensure multi-value field field_fdlm_list exists on Article with a string
# formatter and NO delimiter (verify FAILS until agent sets a <br> delimiter).
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node","field_fdlm_list")) {
    FieldStorageConfig::create(["field_name"=>"field_fdlm_list","entity_type"=>"node","type"=>"string","cardinality"=>-1])->save();
  }
  if (!FieldConfig::loadByName("node","article","field_fdlm_list")) {
    FieldConfig::create(["field_name"=>"field_fdlm_list","entity_type"=>"node","bundle"=>"article","label"=>"FDLM List"])->save();
  }
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $vd->setComponent("field_fdlm_list", ["type"=>"string","weight"=>51,"region"=>"content","third_party_settings"=>[]])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: field_fdlm_list present with no delimiter"
