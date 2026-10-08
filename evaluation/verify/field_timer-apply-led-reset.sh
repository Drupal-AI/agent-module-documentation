#!/usr/bin/env bash
# Execution RESET: ensure datetime field field_ft_led exists on Article with a core
# datetime_default formatter on the default view display, so verify FAILS until switched.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_ft_led")) {
    FieldStorageConfig::create(["field_name"=>"field_ft_led","entity_type"=>"node","type"=>"datetime","settings"=>["datetime_type"=>"datetime"]])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_ft_led")) {
    FieldConfig::create(["field_name"=>"field_ft_led","entity_type"=>"node","bundle"=>"article","label"=>"LED Timer"])->save();
  }
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $vd->setComponent("field_ft_led", ["type"=>"datetime_default","label"=>"hidden","settings"=>[],"weight"=>52,"region"=>"content"])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: field_ft_led present with core datetime_default formatter"
