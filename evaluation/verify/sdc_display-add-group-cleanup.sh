#!/usr/bin/env bash
# Execution CLEANUP (sdc_display, layman): remove any sdc_display field group. Exit 0.
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
echo "cleanup: sdc_display field groups removed"
exit 0
