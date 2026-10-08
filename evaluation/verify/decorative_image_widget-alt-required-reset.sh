#!/usr/bin/env bash
# Execution RESET: ensure image field field_diw_alt exists on Article with alt_field_required
# TRUE (so decorative_image_widget's checkbox is NOT even offered) and no decorative setting.
# verify FAILS until the agent makes alt optional AND enables the decorative checkbox.
# Two-save pattern preserves image_image against lightning_media_image. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node","field_diw_alt")) {
    FieldStorageConfig::create(["field_name"=>"field_diw_alt","entity_type"=>"node","type"=>"image"])->save();
  }
  if (!FieldConfig::loadByName("node","article","field_diw_alt")) {
    FieldConfig::create(["field_name"=>"field_diw_alt","entity_type"=>"node","bundle"=>"article","label"=>"DIW Alt Image","settings"=>["alt_field"=>TRUE,"alt_field_required"=>TRUE]])->save();
  } else {
    $fc=FieldConfig::loadByName("node","article","field_diw_alt");
    $fc->setSetting("alt_field",TRUE)->setSetting("alt_field_required",TRUE)->save();
  }
  $s=\Drupal::entityTypeManager()->getStorage("entity_form_display");
  $fd=$s->load("node.article.default");
  $fd->setComponent("field_diw_alt",["type"=>"image_image","weight"=>60,"region"=>"content","settings"=>[]]);
  $fd->save();
  $fd=$s->loadUnchanged("node.article.default");
  $fd->setComponent("field_diw_alt",["type"=>"image_image","weight"=>60,"region"=>"content","settings"=>[],"third_party_settings"=>[]]);
  $fd->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: field_diw_alt present with alt_field_required=TRUE and no decorative setting"
