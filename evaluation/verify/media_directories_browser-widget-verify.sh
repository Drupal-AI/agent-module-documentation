#!/usr/bin/env bash
# Execution VERIFY for "use the Media Directories Browser widget on field_mdb_assets".
# PASS when the field's component in core.entity_form_display.node.article.default uses the
# widget plugin id media_directories_browser_widget and the component is in the content
# region (i.e. actually visible on the form). Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html

out=$(drush php:eval '
  $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.article.default");
  $c = $fd ? $fd->getComponent("field_mdb_assets") : NULL;
  $type = $c["type"] ?? "none";
  $region = $c["region"] ?? "none";
  $exists = \Drupal::service("plugin.manager.field.widget")->hasDefinition("media_directories_browser_widget");
  $ok = ($type === "media_directories_browser_widget") && ($region === "content") && $exists;
  print ($ok ? "PASS" : "FAIL") . " widget=" . $type . " region=" . $region . " plugin_available=" . var_export($exists, TRUE) . "\n";
' 2>/dev/null)

echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
