#!/usr/bin/env bash
# Execution RESET: ensure email field field_ec_form exists on Article with the CORE email_mailto
# formatter (NOT email_contact_inline), so verify FAILS until the agent switches it. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node","field_ec_form")) { FieldStorageConfig::create(["field_name"=>"field_ec_form","entity_type"=>"node","type"=>"email"])->save(); }
  if (!FieldConfig::loadByName("node","article","field_ec_form")) { FieldConfig::create(["field_name"=>"field_ec_form","entity_type"=>"node","bundle"=>"article","label"=>"Form Email"])->save(); }
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $vd->setComponent("field_ec_form", ["type"=>"email_mailto","label"=>"above","weight"=>53,"settings"=>[]])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: node.article field_ec_form uses core email_mailto"
