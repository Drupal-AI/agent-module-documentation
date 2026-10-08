#!/usr/bin/env bash
# Introspection CLEANUP (ui_styles_layout_builder): disable Layout Builder on node.page default
# display (removes the fixture section), restoring baseline. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $storage = \Drupal::entityTypeManager()->getStorage("entity_view_display");
  $display = $storage->load("node.page.default");
  if ($display) {
    $display->removeAllSections();
    $display->disableLayoutBuilder();
    $display->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: node.page.default Layout Builder disabled (fixture section removed)"
