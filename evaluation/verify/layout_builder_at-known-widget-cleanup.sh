#!/usr/bin/env bash
# Introspection CLEANUP: remove the layout widget component from the lbat_demo form display.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.lbat_demo.default");
  if ($fd) { $fd->removeComponent("layout_builder__layout")->save(); }
' >/dev/null 2>&1
echo "cleanup: layout_builder__layout component removed from node.lbat_demo.default form display"
