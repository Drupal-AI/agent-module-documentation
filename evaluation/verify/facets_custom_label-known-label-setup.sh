#!/usr/bin/env bash
# setup: facet fcl_known with facets_custom_label mapping r|article|Awesome news
set -uo pipefail
cd /var/www/html
drush php:eval '
  $f = \Drupal\facets\Entity\Facet::load("fcl_known");
  if ($f) { $f->delete(); }
  \Drupal\facets\Entity\Facet::create([
    "id" => "fcl_known", "name" => "fcl_known", "url_alias" => "fcl_known",
    "facet_source_id" => "search_api:fcl", "field_identifier" => "type", "weight" => 0,
    "processor_configs" => ["facets_custom_label" => ["processor_id" => "facets_custom_label", "weights" => ["build" => 50], "settings" => ["replacement_values" => "r|article|Awesome news"]]],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: facet fcl_known with facets_custom_label mapping r|article|Awesome news"
