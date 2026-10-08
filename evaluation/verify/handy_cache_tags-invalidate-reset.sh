#!/usr/bin/env bash
# Execution RESET: ensure content type hct_task exists and clear any prior invalidation record of
# its handy bundle cache tag, so verify FAILS until the agent causes it to be invalidated.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\NodeType;
  if (!NodeType::load("hct_task")) {
    NodeType::create(["type" => "hct_task", "name" => "HCT Task"])->save();
  }
' >/dev/null 2>&1
# Remove any existing invalidation counter row for the target tag.
drush sqlq "DELETE FROM cachetags WHERE tag='handy_cache_tags:node:hct_task'" >/dev/null 2>&1
drush cr >/dev/null 2>&1
# Note: drush cr may itself invalidate broad tags but not this specific bundle tag; re-clear it.
drush sqlq "DELETE FROM cachetags WHERE tag='handy_cache_tags:node:hct_task'" >/dev/null 2>&1
echo "reset: hct_task exists; handy_cache_tags:node:hct_task invalidation record cleared"
