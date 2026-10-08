#!/usr/bin/env bash
# Execution RESET: ensure the test view exists (raw write) and the target block is ABSENT, so
# verify FAILS until the agent places a configurable exposed-filter block showing only 'title'.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\Core\Serialization\Yaml;
  use Drupal\block\Entity\Block;
  $vp = "/var/www/html/web/modules/contrib/configurable_views_filter_block/tests/modules/configurable_views_filter_block_test/config/install/views.view.view_simple_exposed_filters.yml";
  if (!\Drupal::config("views.view.view_simple_exposed_filters")->get("id") && file_exists($vp)) {
    \Drupal::service("config.storage")->write("views.view.view_simple_exposed_filters", Yaml::decode(file_get_contents($vp)));
  }
  if ($b = Block::load("cvfb_task")) { $b->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: test view present, block cvfb_task absent"
