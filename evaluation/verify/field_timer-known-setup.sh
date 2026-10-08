#!/usr/bin/env bash
# Introspection SETUP: create datetime field field_ft_known on Article and display it on the
# default view display with the field_timer_simple_text formatter in 'countdown' mode, so an
# agent can read back the formatter id + type setting. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_ft_known")) {
    FieldStorageConfig::create(["field_name"=>"field_ft_known","entity_type"=>"node","type"=>"datetime","settings"=>["datetime_type"=>"datetime"]])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_ft_known")) {
    FieldConfig::create(["field_name"=>"field_ft_known","entity_type"=>"node","bundle"=>"article","label"=>"Known Timer"])->save();
  }
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $vd->setComponent("field_ft_known", ["type"=>"field_timer_simple_text","label"=>"hidden","settings"=>["type"=>"countdown"],"weight"=>50,"region"=>"content"])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: node.article field_ft_known displayed with field_timer_simple_text (type=countdown)"
