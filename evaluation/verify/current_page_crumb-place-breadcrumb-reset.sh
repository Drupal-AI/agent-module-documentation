#!/usr/bin/env bash
# Execution RESET: ensure the Canvas Stark theme has NO enabled Breadcrumb block, so verify
# FAILS until the agent places one. Deletes any system_breadcrumb_block placed in canvas_stark
# (there are none in the shipped baseline). Does NOT touch olivero/claro breadcrumb blocks.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  foreach (\Drupal::entityTypeManager()->getStorage("block")
      ->loadByProperties(["plugin" => "system_breadcrumb_block", "theme" => "canvas_stark"]) as $b) {
    $b->delete();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: no system_breadcrumb_block in canvas_stark"
