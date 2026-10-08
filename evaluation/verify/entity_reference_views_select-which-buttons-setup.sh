#!/usr/bin/env bash
# Introspection SETUP: create two entity_reference fields on Article - field_erv_sel (widget
# erviews_options_select) and field_erv_btn (widget erviews_options_buttons) - so an agent must
# inspect the form display to say which uses checkboxes/radio buttons. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.article.default");
  foreach ([["field_erv_sel","erviews_options_select"],["field_erv_btn","erviews_options_buttons"]] as [$fn,$w]) {
    if (!FieldStorageConfig::loadByName("node",$fn)) {
      FieldStorageConfig::create(["field_name"=>$fn,"entity_type"=>"node","type"=>"entity_reference","settings"=>["target_type"=>"node"]])->save();
    }
    if (!FieldConfig::loadByName("node","article",$fn)) {
      FieldConfig::create(["field_name"=>$fn,"entity_type"=>"node","bundle"=>"article","label"=>strtoupper($fn)])->save();
    }
    $fd->setComponent($fn, ["type"=>$w,"region"=>"content","weight"=>61])->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: field_erv_sel=erviews_options_select, field_erv_btn=erviews_options_buttons"
