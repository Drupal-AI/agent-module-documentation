#!/usr/bin/env bash
# Execution RESET: remove any lbb_task_* Layout Builder Browser config entities so the site
# has NO curated category/block for this task and verify fails on empty state.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $blkStorage = \Drupal::entityTypeManager()->getStorage("layout_builder_browser_block");
  foreach ($blkStorage->loadMultiple() as $id => $e) {
    if (str_starts_with($id, "lbb_task_")) { $e->delete(); }
  }
  $catStorage = \Drupal::entityTypeManager()->getStorage("layout_builder_browser_blockcat");
  foreach ($catStorage->loadMultiple() as $id => $e) {
    if (str_starts_with($id, "lbb_task_")) { $e->delete(); }
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: all lbb_task_* layout_builder_browser entities removed"
