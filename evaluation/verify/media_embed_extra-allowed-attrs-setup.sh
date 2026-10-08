#!/usr/bin/env bash
# Introspection SETUP: create text format mee_attrs whose allowed HTML permits
# <drupal-media ... data-width data-height>.
set -uo pipefail
cd /var/www/html
drush php:eval 'use Drupal\filter\Entity\FilterFormat;
if ($f = FilterFormat::load("mee_attrs")) { $f->delete(); }
FilterFormat::create([
  "format" => "mee_attrs", "name" => "MEE Attrs", "weight" => 20,
  "filters" => [
    "media_embed" => ["status" => TRUE, "weight" => 100],
    "filter_html" => ["status" => TRUE, "weight" => -10, "settings" => ["allowed_html" => "<a href hreflang> <p> <br> <em> <strong> <drupal-media data-entity-type data-entity-uuid data-view-mode data-align data-caption data-width data-height alt title>", "filter_html_help" => TRUE, "filter_html_nofollow" => FALSE]],
  ],
])->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: filter.format.mee_attrs created with data-width/data-height allowed"
