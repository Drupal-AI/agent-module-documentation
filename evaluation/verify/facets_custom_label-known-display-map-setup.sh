#!/usr/bin/env bash
# setup: facet fcl_map with facets_custom_label mapping d|Apple|Apple products
set -uo pipefail
cd /var/www/html
drush php:eval '
  $f = \Drupal\facets\Entity\Facet::load("fcl_map");
  if ($f) { $f->delete(); }
  \Drupal\facets\Entity\Facet::create([
    "id" => "fcl_map", "name" => "fcl_map", "url_alias" => "fcl_map",
    "facet_source_id" => "search_api:fcl", "field_identifier" => "type", "weight" => 0,
    "processor_configs" => ["facets_custom_label" => ["processor_id" => "facets_custom_label", "weights" => ["build" => 50], "settings" => ["replacement_values" => "d|Apple|Apple products"]]],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: facet fcl_map with facets_custom_label mapping d|Apple|Apple products"
