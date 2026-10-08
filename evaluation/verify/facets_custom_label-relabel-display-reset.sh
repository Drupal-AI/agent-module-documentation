#!/usr/bin/env bash
# reset: facet fcl_relabel present with facets_custom_label processor but empty replacement_values
set -uo pipefail
cd /var/www/html
drush php:eval '
  $f = \Drupal\facets\Entity\Facet::load("fcl_relabel");
  if ($f) { $f->delete(); }
  \Drupal\facets\Entity\Facet::create([
    "id" => "fcl_relabel", "name" => "fcl_relabel", "url_alias" => "fcl_relabel",
    "facet_source_id" => "search_api:fcl", "field_identifier" => "type", "weight" => 0,
    "processor_configs" => ["facets_custom_label" => ["processor_id" => "facets_custom_label", "weights" => ["build" => 50], "settings" => ["replacement_values" => ""]]],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: facet fcl_relabel present with facets_custom_label processor but empty replacement_values"
