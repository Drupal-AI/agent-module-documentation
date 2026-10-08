#!/usr/bin/env bash
# Execution CLEANUP (popup_field_group, layman): remove any popup field group from the Article view display. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $changed = FALSE;
  foreach ($vd->getThirdPartySettings("field_group") as $name => $g) {
    if (($g["format_type"] ?? NULL) === "popup") { $vd->unsetThirdPartySetting("field_group", $name); $changed = TRUE; }
  }
  if ($changed) { $vd->save(); }
' >/dev/null 2>&1 || true
echo "cleanup: popup groups removed from node.article view display"
exit 0
