#!/usr/bin/env bash
# Introspection CLEANUP (sdc_display): remove group_sdcd_known. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  if ($vd->getThirdPartySetting("field_group", "group_sdcd_known")) { $vd->unsetThirdPartySetting("field_group", "group_sdcd_known"); $vd->save(); }
' >/dev/null 2>&1 || true
echo "cleanup: group_sdcd_known removed"
exit 0
