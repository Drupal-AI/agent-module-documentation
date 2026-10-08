#!/usr/bin/env bash
# Introspection SETUP: create text format 'no_nbsp_med' with the No-nbsp filter enabled and
# preserve_placeholders ON, so an inspecting agent can read the live filter config. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\filter\Entity\FilterFormat;
  $f = FilterFormat::load("no_nbsp_med") ?: FilterFormat::create(["format" => "no_nbsp_med", "name" => "No Nbsp Med", "weight" => 20, "filters" => []]);
  $f->setFilterConfig("filter_no_nbsp", ["status" => TRUE, "settings" => ["preserve_placeholders" => TRUE]]);
  $f->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: text format no_nbsp_med has filter_no_nbsp enabled, preserve_placeholders=true"
