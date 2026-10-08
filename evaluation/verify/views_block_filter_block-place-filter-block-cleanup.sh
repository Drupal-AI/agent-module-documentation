#!/usr/bin/env bash
# Execution CLEANUP: delete the vbfb_place view and any block placement of its exposed
# filter block. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\views\Entity\View;
  foreach (\Drupal::entityTypeManager()->getStorage("block")->loadMultiple() as $b) {
    if ($b->getPluginId() === "views_exposed_filter_block:vbfb_place-block_1") { $b->delete(); }
  }
  if ($v = View::load("vbfb_place")) { $v->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: vbfb_place view and its exposed filter block removed"
