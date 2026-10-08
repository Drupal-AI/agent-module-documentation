#!/usr/bin/env bash
# reset: facet fcl_task present WITHOUT facets_custom_label processor
set -uo pipefail
cd /var/www/html
drush php:eval '
  $f = \Drupal\facets\Entity\Facet::load("fcl_task");
  if ($f) { $f->delete(); }
  \Drupal\facets\Entity\Facet::create([
    "id" => "fcl_task", "name" => "fcl_task", "url_alias" => "fcl_task",
    "facet_source_id" => "search_api:fcl", "field_identifier" => "type", "weight" => 0,
    "processor_configs" => [],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: facet fcl_task present WITHOUT facets_custom_label processor"
