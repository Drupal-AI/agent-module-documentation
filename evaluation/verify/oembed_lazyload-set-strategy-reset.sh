#!/usr/bin/env bash
# Execution RESET: ensure field_oel_strat on Article uses the lazyload_oembed formatter with
# strategy=intersection_observer (the default), so verify FAILS until the agent switches the
# strategy to onclick. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node","field_oel_strat")) {
    FieldStorageConfig::create(["field_name"=>"field_oel_strat","entity_type"=>"node","type"=>"string"])->save();
  }
  if (!FieldConfig::loadByName("node","article","field_oel_strat")) {
    FieldConfig::create(["field_name"=>"field_oel_strat","entity_type"=>"node","bundle"=>"article","label"=>"OEL Strat"])->save();
  }
  \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default")
    ->setComponent("field_oel_strat", ["type"=>"lazyload_oembed","label"=>"hidden","region"=>"content",
      "settings"=>["strategy"=>"intersection_observer","intersection_observer_margin"=>"","max_width"=>0,"max_height"=>0]])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: field_oel_strat lazyload_oembed strategy=intersection_observer"
