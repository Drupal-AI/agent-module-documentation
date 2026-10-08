#!/usr/bin/env bash
# Introspection SETUP: create a namespaced text format `sce_eval` with the `shortcode` filter
# enabled at an unusual weight (9) and the `col` shortcode on, so an inspecting agent can read
# the weight back from live config. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\filter\Entity\FilterFormat;
  if ($f = FilterFormat::load("sce_eval")) { $f->delete(); }
  FilterFormat::create([
    "format" => "sce_eval",
    "name" => "Shortcode Example Eval (weight)",
    "filters" => [
      "shortcode" => ["status" => TRUE, "weight" => 9, "settings" => ["col" => TRUE]],
    ],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: sce_eval has shortcode filter enabled at weight=9"
