#!/usr/bin/env bash
# Execution RESET: create mee_ready with filter_html ON but WITHOUT data-width/data-height
# and with media_embed OFF, so verify FAILS until the agent fixes it.
set -uo pipefail
cd /var/www/html
drush php:eval 'use Drupal\filter\Entity\FilterFormat;
if ($f = FilterFormat::load("mee_ready")) { $f->delete(); }
FilterFormat::create([
  "format" => "mee_ready", "name" => "MEE Ready", "weight" => 20,
  "filters" => [
    "media_embed" => ["status" => FALSE, "weight" => 100],
    "filter_html" => ["status" => TRUE, "weight" => -10, "settings" => ["allowed_html" => "<a href hreflang> <p> <br> <em> <strong> <drupal-media data-entity-type data-entity-uuid data-view-mode data-align data-caption alt title>", "filter_html_help" => TRUE, "filter_html_nofollow" => FALSE]],
  ],
])->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: filter.format.mee_ready present (media_embed OFF, no dimension attrs)"
