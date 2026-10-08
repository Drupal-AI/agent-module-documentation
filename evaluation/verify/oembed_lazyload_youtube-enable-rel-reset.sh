#!/usr/bin/env bash
# Execution RESET: ensure field_oly_rel on Article uses lazyload_oembed with YouTube rel FALSE,
# so verify FAILS until the agent enables the same-channel related-videos option. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node","field_oly_rel")) {
    FieldStorageConfig::create(["field_name"=>"field_oly_rel","entity_type"=>"node","type"=>"string"])->save();
  }
  if (!FieldConfig::loadByName("node","article","field_oly_rel")) {
    FieldConfig::create(["field_name"=>"field_oly_rel","entity_type"=>"node","bundle"=>"article","label"=>"OLY Rel"])->save();
  }
  \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default")
    ->setComponent("field_oly_rel", ["type"=>"lazyload_oembed","label"=>"hidden","region"=>"content",
      "settings"=>["strategy"=>"intersection_observer","intersection_observer_margin"=>"","max_width"=>0,"max_height"=>0],
      "third_party_settings"=>["oembed_lazyload_youtube"=>["autoplay"=>false,"modestbranding"=>false,"enablejsapi"=>false,"origin"=>false,"hideinfo"=>false,"rel"=>false]]])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: field_oly_rel lazyload_oembed youtube.rel=false"
