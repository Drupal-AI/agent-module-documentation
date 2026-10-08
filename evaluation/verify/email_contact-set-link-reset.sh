#!/usr/bin/env bash
# Execution RESET: ensure email field field_ec_task exists on Article and its default view
# display uses the CORE email_mailto formatter (NOT email_contact_link), so verify FAILS until
# the agent switches it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node","field_ec_task")) { FieldStorageConfig::create(["field_name"=>"field_ec_task","entity_type"=>"node","type"=>"email"])->save(); }
  if (!FieldConfig::loadByName("node","article","field_ec_task")) { FieldConfig::create(["field_name"=>"field_ec_task","entity_type"=>"node","bundle"=>"article","label"=>"Task Email"])->save(); }
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $vd->setComponent("field_ec_task", ["type"=>"email_mailto","label"=>"above","weight"=>52,"settings"=>[]])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: node.article field_ec_task uses core email_mailto"
