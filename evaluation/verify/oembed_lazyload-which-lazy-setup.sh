#!/usr/bin/env bash
# Introspection SETUP: two text fields on Article - field_oel_lazy (formatter lazyload_oembed)
# and field_oel_plain (core string formatter) - so an agent must inspect the view display to say
# which lazy-loads its oEmbed. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  foreach ([["field_oel_lazy","lazyload_oembed"],["field_oel_plain","string"]] as [$fn,$fmt]) {
    if (!FieldStorageConfig::loadByName("node",$fn)) {
      FieldStorageConfig::create(["field_name"=>$fn,"entity_type"=>"node","type"=>"string"])->save();
    }
    if (!FieldConfig::loadByName("node","article",$fn)) {
      FieldConfig::create(["field_name"=>$fn,"entity_type"=>"node","bundle"=>"article","label"=>strtoupper($fn)])->save();
    }
    $settings = ($fmt === "lazyload_oembed") ? ["strategy"=>"intersection_observer","intersection_observer_margin"=>"","max_width"=>0,"max_height"=>0] : [];
    $vd->setComponent($fn, ["type"=>$fmt,"label"=>"hidden","region"=>"content","settings"=>$settings])->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: field_oel_lazy=lazyload_oembed, field_oel_plain=string"
