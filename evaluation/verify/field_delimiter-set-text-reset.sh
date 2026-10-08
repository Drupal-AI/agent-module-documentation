#!/usr/bin/env bash
# Execution RESET: ensure multi-value field field_fdlm_task exists on Article with a string
# formatter on the default view display and NO delimiter set (verify FAILS until agent sets it).
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node","field_fdlm_task")) {
    FieldStorageConfig::create(["field_name"=>"field_fdlm_task","entity_type"=>"node","type"=>"string","cardinality"=>-1])->save();
  }
  if (!FieldConfig::loadByName("node","article","field_fdlm_task")) {
    FieldConfig::create(["field_name"=>"field_fdlm_task","entity_type"=>"node","bundle"=>"article","label"=>"FDLM Task"])->save();
  }
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $vd->setComponent("field_fdlm_task", ["type"=>"string","weight"=>50,"region"=>"content","third_party_settings"=>[]])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: field_fdlm_task present with no delimiter"
