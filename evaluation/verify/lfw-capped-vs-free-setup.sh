#!/usr/bin/env bash
# Introspection SETUP: two unlimited fields on Article — field_lfw_capped (limit_values 2)
# and field_lfw_free (limit_values 0, i.e. no cap) — so the agent must inspect the live form
# display to tell which one is capped and to what. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  foreach ([["field_lfw_capped","Capped"],["field_lfw_free","Free"]] as $x) {
    [$fn,$lbl] = $x;
    if (!FieldStorageConfig::loadByName("node", $fn)) {
      FieldStorageConfig::create(["field_name"=>$fn,"entity_type"=>"node","type"=>"string","cardinality"=>-1])->save();
    }
    if (!FieldConfig::loadByName("node","article",$fn)) {
      FieldConfig::create(["field_name"=>$fn,"entity_type"=>"node","bundle"=>"article","label"=>$lbl])->save();
    }
  }
  $fd=\Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.article.default");
  $fd->setComponent("field_lfw_capped",["type"=>"string_textfield","weight"=>50,"region"=>"content","third_party_settings"=>["limited_field_widgets"=>["limit_values"=>2]]]);
  $fd->setComponent("field_lfw_free",["type"=>"string_textfield","weight"=>51,"region"=>"content","third_party_settings"=>["limited_field_widgets"=>["limit_values"=>0]]]);
  $fd->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: field_lfw_capped=2, field_lfw_free=0"
