#!/usr/bin/env bash
# Execution CLEANUP: restore baseline - remove any system_breadcrumb_block from canvas_stark
# (the shipped state has none). Does NOT touch olivero/claro breadcrumb blocks. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  foreach (\Drupal::entityTypeManager()->getStorage("block")
      ->loadByProperties(["plugin" => "system_breadcrumb_block", "theme" => "canvas_stark"]) as $b) {
    $b->delete();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: canvas_stark has no system_breadcrumb_block (baseline)"
