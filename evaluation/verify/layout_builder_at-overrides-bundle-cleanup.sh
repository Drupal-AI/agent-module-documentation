#!/usr/bin/env bash
# Introspection CLEANUP: switch Layout Builder overrides back off on lbat_demo.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.lbat_demo.default");
  if ($vd) {
    $vd->setThirdPartySetting("layout_builder", "allow_custom", FALSE)
       ->setThirdPartySetting("layout_builder", "enabled", FALSE)
       ->save();
  }
' >/dev/null 2>&1
echo "cleanup: layout_builder disabled on node.lbat_demo.default view display"
