#!/usr/bin/env bash
# Introspection SETUP: create a text format noopener_med_fmt with the noopener filter
# (filter_noopener) enabled, so an inspecting agent can read back which format has it on.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\filter\Entity\FilterFormat;
  if (!FilterFormat::load("noopener_med_fmt")) {
    FilterFormat::create([
      "format" => "noopener_med_fmt",
      "name" => "Noopener Med Format",
      "filters" => ["filter_noopener" => ["status" => TRUE, "weight" => 20]],
    ])->save();
  }
  else {
    $f = FilterFormat::load("noopener_med_fmt");
    $filters = $f->get("filters");
    $filters["filter_noopener"] = ["id"=>"filter_noopener","provider"=>"noopener_filter","status"=>TRUE,"weight"=>20,"settings"=>[]];
    $f->set("filters", $filters)->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: text format noopener_med_fmt has filter_noopener enabled"
