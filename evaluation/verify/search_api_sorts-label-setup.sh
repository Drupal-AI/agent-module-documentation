#!/usr/bin/env bash
# Introspection SETUP: create a search_api_sorts_field for field 'created' on display
# 'sapisorts_display2' with a distinctive label 'Freshest first', so an agent can read the
# label back. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\search_api_sorts\Entity\SearchApiSortsField;
  $id="sapisorts_display2_created";
  if ($e=SearchApiSortsField::load($id)) { $e->delete(); }
  SearchApiSortsField::create([
    "id"=>$id,"display_id"=>"sapisorts_display2","field_identifier"=>"created",
    "status"=>TRUE,"default_sort"=>FALSE,"default_order"=>"asc","label"=>"Freshest first","weight"=>0,
  ])->save();
' >/dev/null 2>&1
echo "setup: display sapisorts_display2 field created label='Freshest first'"
