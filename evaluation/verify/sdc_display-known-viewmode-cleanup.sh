#!/usr/bin/env bash
# Introspection CLEANUP (sdc_display): remove the sdc_display view-mode mapping. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  foreach (["enabled","component","mappings"] as $k) { $vd->unsetThirdPartySetting("sdc_display", $k); }
  $vd->save();
' >/dev/null 2>&1 || true
echo "cleanup: sdc_display view-mode mapping removed from node.article view display"
exit 0
