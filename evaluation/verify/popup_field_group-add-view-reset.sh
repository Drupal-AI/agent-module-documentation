#!/usr/bin/env bash
# Execution RESET (popup_field_group, layman): remove ANY popup-format field group from the
# Article default VIEW display so verify FAILS until one is added. Config-only. Idempotent. Exit 0.
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
echo "reset: no popup field groups on node.article view display"
exit 0
