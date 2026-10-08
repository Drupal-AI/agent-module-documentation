#!/usr/bin/env bash
# Execution RESET: ensure a Search API index 'sasblk_idx' exists (so the derivative block
# search_api_stats_block:sasblk_idx is available to place) and remove any prior placement so
# verify FAILS on empty state. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\search_api\Entity\Index;
  if (!Index::load("sasblk_idx")) {
    Index::create(["id"=>"sasblk_idx","name"=>"SAS Blk Idx","datasource_settings"=>["entity:node"=>[]]])->save();
  }
  foreach (\Drupal::entityTypeManager()->getStorage("block")->loadMultiple() as $b) {
    if ($b->get("plugin") === "search_api_stats_block:sasblk_idx") { $b->delete(); }
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: index sasblk_idx present; no search_api_stats_block:sasblk_idx placed"
