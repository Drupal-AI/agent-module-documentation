#!/usr/bin/env bash
# Introspection SETUP: create text format mdc_eval_format with the legacy-embed filter
# (media_directories_legacy_embed) enabled at weight 0 (before media_embed at 100) and a known
# inline_display_modes list of ["default", "teaser"]. The agent must read the live filter
# settings to answer. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html

drush php:eval '
  use Drupal\filter\Entity\FilterFormat;

  $id = "mdc_eval_format";
  $format = FilterFormat::load($id) ?: FilterFormat::create(["format" => $id, "name" => "MDC eval format", "weight" => 58]);
  $format->setFilterConfig("filter_html", [
    "status" => TRUE, "weight" => -10,
    "settings" => ["allowed_html" => "<p> <br> <a href data-entity-type data-entity-uuid> <drupal-entity data-entity-type data-entity-uuid data-entity-embed-display data-entity-embed-display-settings data-align> <drupal-media data-entity-type data-entity-uuid data-view-mode data-align data-width data-height>"],
  ]);
  $format->setFilterConfig("media_directories_legacy_embed", [
    "status" => TRUE, "weight" => 0,
    "settings" => ["inline_display_modes" => ["default", "teaser"]],
  ]);
  $format->setFilterConfig("media_embed", ["status" => TRUE, "weight" => 100, "settings" => []]);
  $format->save();
' >/dev/null 2>&1

echo "setup: mdc_eval_format legacy embed filter on, inline_display_modes=[default,teaser]"
