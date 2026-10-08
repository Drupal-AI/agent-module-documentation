#!/usr/bin/env bash
# Introspection SETUP: create text format 'thsa_med_empty' with ONLY the empty-th-to-td filter
# enabled, so an agent can inspect the config and identify which THSA filter is active. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\filter\Entity\FilterFormat;
  if ($f = FilterFormat::load("thsa_med_empty")) { $f->delete(); }
  FilterFormat::create(["format"=>"thsa_med_empty","name"=>"THSA Med Empty","filters"=>[
    "table_header_scope_attribute_empty_th_to_td"=>["status"=>TRUE,"weight"=>12],
  ]])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: text format thsa_med_empty has table_header_scope_attribute_empty_th_to_td enabled"
