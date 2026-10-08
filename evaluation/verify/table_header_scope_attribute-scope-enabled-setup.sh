#!/usr/bin/env bash
# Introspection SETUP: create text format 'thsa_med_scope' with ONLY the scope-attribute filter
# enabled, so an agent can inspect the format config and report which THSA filter is active. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\filter\Entity\FilterFormat;
  if ($f = FilterFormat::load("thsa_med_scope")) { $f->delete(); }
  FilterFormat::create(["format"=>"thsa_med_scope","name"=>"THSA Med Scope","filters"=>[
    "table_header_scope_attribute"=>["status"=>TRUE,"weight"=>10],
  ]])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: text format thsa_med_scope has table_header_scope_attribute enabled"
