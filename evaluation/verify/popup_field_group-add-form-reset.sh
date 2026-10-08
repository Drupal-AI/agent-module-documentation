#!/usr/bin/env bash
# Execution RESET (popup_field_group): remove ANY popup-format field group from the Article
# default FORM display so verify FAILS until the agent adds one. Config-only. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.article.default");
  $changed = FALSE;
  foreach ($fd->getThirdPartySettings("field_group") as $name => $g) {
    if (($g["format_type"] ?? NULL) === "popup") { $fd->unsetThirdPartySetting("field_group", $name); $changed = TRUE; }
  }
  if ($changed) { $fd->save(); }
' >/dev/null 2>&1 || true
echo "reset: no popup field groups on node.article form display"
exit 0
