#!/usr/bin/env bash
# Execution RESET (sdc_display, layman): remove any field group using the 'sdc_display' formatter
# from the Article default view display so verify FAILS until one is added. Config-only. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $changed = FALSE;
  foreach ($vd->getThirdPartySettings("field_group") as $name => $g) {
    if (($g["format_type"] ?? NULL) === "sdc_display") { $vd->unsetThirdPartySetting("field_group", $name); $changed = TRUE; }
  }
  if ($changed) { $vd->save(); }
' >/dev/null 2>&1 || true
echo "reset: no sdc_display field groups on node.article view display"
exit 0
