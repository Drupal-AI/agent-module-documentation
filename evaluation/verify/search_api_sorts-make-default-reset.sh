#!/usr/bin/env bash
# Execution RESET: ensure an ENABLED but NON-default 'price' sort exists for display
# 'sapisorts_display3', so verify (which requires default_sort=TRUE) fails until the agent
# makes it the default. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\search_api_sorts\Entity\SearchApiSortsField;
  $id="sapisorts_display3_price";
  if ($e=SearchApiSortsField::load($id)) { $e->delete(); }
  SearchApiSortsField::create([
    "id"=>$id,"display_id"=>"sapisorts_display3","field_identifier"=>"price",
    "status"=>TRUE,"default_sort"=>FALSE,"default_order"=>"asc","label"=>"Price","weight"=>0,
  ])->save();
' >/dev/null 2>&1
echo "reset: sapisorts_display3 price sort present, default_sort=FALSE"
