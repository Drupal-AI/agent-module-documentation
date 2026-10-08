#!/usr/bin/env bash
# Execution RESET: ensure unlimited field field_lfw_single exists on Article with string_textfield widget
# and limit_values FORCED to 0 (no cap) so verify FAILS until the agent sets the cap. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_lfw_single")) {
    FieldStorageConfig::create(["field_name"=>"field_lfw_single","entity_type"=>"node","type"=>"string","cardinality"=>-1])->save();
  }
  if (!FieldConfig::loadByName("node","article","field_lfw_single")) {
    FieldConfig::create(["field_name"=>"field_lfw_single","entity_type"=>"node","bundle"=>"article","label"=>"Single"])->save();
  }
  $fd=\Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.article.default");
  $fd->setComponent("field_lfw_single",["type"=>"string_textfield","weight"=>50,"region"=>"content","third_party_settings"=>["limited_field_widgets"=>["limit_values"=>0]]])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: field_lfw_single present, limit_values=0"
