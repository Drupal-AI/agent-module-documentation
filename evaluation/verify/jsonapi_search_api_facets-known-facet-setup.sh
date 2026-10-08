#!/usr/bin/env bash
# Introspection SETUP: create a Facets facet (jsaf_known) on a jsonapi_search_api_facets
# source. The submodule's presave hook sets its widget to jsonapi_search_api, which the
# agent can read back. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\facets\Entity\Facet;
  if ($f = Facet::load("jsaf_known")) { $f->delete(); }
  Facet::create([
    "id" => "jsaf_known", "name" => "JSAF Known",
    "facet_source_id" => "jsonapi_search_api_facets:primary",
    "field_identifier" => "type", "url_alias" => "type",
  ])->save();
' >/dev/null 2>&1
echo "setup: facet jsaf_known on jsonapi_search_api_facets:primary (widget set by submodule)"
