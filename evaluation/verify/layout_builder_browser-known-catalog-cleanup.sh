#!/usr/bin/env bash
# Introspection CLEANUP: delete the catalog created by the matching setup. Restores baseline
# (no layout_builder_browser config entities named lbb_eval_*). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $catStorage = \Drupal::entityTypeManager()->getStorage("layout_builder_browser_blockcat");
  $blkStorage = \Drupal::entityTypeManager()->getStorage("layout_builder_browser_block");
  foreach (["lbb_eval_powered", "lbb_eval_help"] as $id) {
    if ($e = $blkStorage->load($id)) { $e->delete(); }
  }
  if ($e = $catStorage->load("lbb_eval_cat")) { $e->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: lbb_eval_cat, lbb_eval_powered, lbb_eval_help removed"
