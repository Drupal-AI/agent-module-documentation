#!/usr/bin/env bash
# Introspection SETUP: create text format vee_fmt with the views_embed filter enabled.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\filter\Entity\FilterFormat;
  if ($f = FilterFormat::load("vee_fmt")) { $f->delete(); }
  FilterFormat::create(["format" => "vee_fmt", "name" => "VEE Fmt", "weight" => 20,
    "filters" => ["views_embed" => ["status" => TRUE, "weight" => 100],
      "filter_html" => ["status" => TRUE, "weight" => -10, "settings" => ["allowed_html" => "<a href hreflang> <p> <br> <em> <strong> <drupal-views data-view-name data-view-display data-view-arguments data-embed-button data-align data-caption>"]]]])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: filter.format.vee_fmt with views_embed enabled"
