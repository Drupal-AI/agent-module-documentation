#!/usr/bin/env bash
# Introspection SETUP: raw-write the module's test view (exposed filters title,uid; page_1 has
# 'exposed form in block'), then place a configurable exposed-filter block that shows ONLY the
# 'uid' filter, so the agent can read visible_filters back. Idempotent. Exit 0.
# (Raw config.storage write avoids an unrelated site-wide vefl_bef fatal on view entity save.)
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
  if ($b = Block::load("cvfb_probe")) { $b->delete(); }
  Block::create([
    "id" => "cvfb_probe", "plugin" => "configurable_views_filter_block_block:view_simple_exposed_filters-page_1", "theme" => "olivero", "region" => "content",
    "settings" => ["id" => "configurable_views_filter_block_block:view_simple_exposed_filters-page_1", "label" => "CVFB Probe", "label_display" => "0",
      "visible_filters" => ["uid" => "uid"], "no_groups" => FALSE, "no_reset" => FALSE, "no_sort" => FALSE, "no_pager" => FALSE],
    "visibility" => [],
  ])->save();
' >/dev/null 2>&1
echo "setup: block cvfb_probe placed with visible_filters=[uid]"
