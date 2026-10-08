#!/usr/bin/env bash
# Introspection SETUP: place a configurable exposed-filter block with the reset button and sort
# hidden (no_reset=TRUE, no_sort=TRUE), all filters visible, so the agent can read which
# visibility options are enabled. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\Core\Serialization\Yaml;
  $vp = "/var/www/html/web/modules/contrib/configurable_views_filter_block/tests/modules/configurable_views_filter_block_test/config/install/views.view.view_simple_exposed_filters.yml";
  if (!\Drupal::config("views.view.view_simple_exposed_filters")->get("id") && file_exists($vp)) {
    \Drupal::service("config.storage")->write("views.view.view_simple_exposed_filters", Yaml::decode(file_get_contents($vp)));
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
drush php:eval '
  use Drupal\block\Entity\Block;
  if ($b = Block::load("cvfb_options")) { $b->delete(); }
  Block::create([
    "id" => "cvfb_options", "plugin" => "configurable_views_filter_block_block:view_simple_exposed_filters-page_1", "theme" => "olivero", "region" => "content",
    "settings" => ["id" => "configurable_views_filter_block_block:view_simple_exposed_filters-page_1", "label" => "CVFB Options", "label_display" => "0",
      "visible_filters" => ["title" => "title", "uid" => "uid"], "no_groups" => FALSE, "no_reset" => TRUE, "no_sort" => TRUE, "no_pager" => FALSE],
    "visibility" => [],
  ])->save();
' >/dev/null 2>&1
echo "setup: block cvfb_options placed with no_reset=TRUE no_sort=TRUE"
