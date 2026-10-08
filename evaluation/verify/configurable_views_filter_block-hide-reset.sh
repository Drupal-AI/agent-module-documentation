#!/usr/bin/env bash
# Execution RESET: ensure the test view exists and create block cvfb_hide with ALL filters
# visible and no visibility toggles (no_sort=FALSE, no_reset=FALSE), so verify FAILS until the
# agent hides the sort and reset. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\Core\Serialization\Yaml;
  use Drupal\block\Entity\Block;
  $vp = "/var/www/html/web/modules/contrib/configurable_views_filter_block/tests/modules/configurable_views_filter_block_test/config/install/views.view.view_simple_exposed_filters.yml";
  if (!\Drupal::config("views.view.view_simple_exposed_filters")->get("id") && file_exists($vp)) {
    \Drupal::service("config.storage")->write("views.view.view_simple_exposed_filters", Yaml::decode(file_get_contents($vp)));
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
drush php:eval '
  use Drupal\block\Entity\Block;
  if ($b = Block::load("cvfb_hide")) { $b->delete(); }
  Block::create([
    "id" => "cvfb_hide", "plugin" => "configurable_views_filter_block_block:view_simple_exposed_filters-page_1", "theme" => "olivero", "region" => "content",
    "settings" => ["id" => "configurable_views_filter_block_block:view_simple_exposed_filters-page_1", "label" => "CVFB Hide", "label_display" => "0",
      "visible_filters" => ["title" => "title", "uid" => "uid"], "no_groups" => FALSE, "no_reset" => FALSE, "no_sort" => FALSE, "no_pager" => FALSE],
    "visibility" => [],
  ])->save();
' >/dev/null 2>&1
echo "reset: block cvfb_hide present with no_sort=FALSE no_reset=FALSE"
