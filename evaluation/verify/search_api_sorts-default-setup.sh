#!/usr/bin/env bash
# Introspection SETUP: create a search_api_sorts_field marking 'price' as the default sort
# (desc) for display 'sapisorts_display', so an agent can read back the default sort/order.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\search_api_sorts\Entity\SearchApiSortsField;
  $id="sapisorts_display_price";
  if ($e=SearchApiSortsField::load($id)) { $e->delete(); }
  SearchApiSortsField::create([
    "id"=>$id,"display_id"=>"sapisorts_display","field_identifier"=>"price",
    "status"=>TRUE,"default_sort"=>TRUE,"default_order"=>"desc","label"=>"Price","weight"=>0,
  ])->save();
' >/dev/null 2>&1
echo "setup: display sapisorts_display default sort = price (desc)"
