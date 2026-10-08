#!/usr/bin/env bash
# Introspection SETUP: reset the acquia_dam_integration_links queue and enqueue exactly 2
# marker items, so an agent can read the queue depth this submodule feeds. Local Drupal queue
# only (no DAM API). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $q = \Drupal::queue("acquia_dam_integration_links");
  $q->deleteQueue();
  $q->createQueue();
  $q->createItem(["eval" => "aitl-marker-1"]);
  $q->createItem(["eval" => "aitl-marker-2"]);
' >/dev/null 2>&1
echo "setup: acquia_dam_integration_links queue reset with 2 items"
