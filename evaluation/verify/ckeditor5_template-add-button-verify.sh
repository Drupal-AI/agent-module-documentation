#!/usr/bin/env bash
# HARD (execution) verify: did the agent add the ckeditor5_template Template button to the
# full_html text format and configure a templates file? Prints PASS/FAIL and exits 0 (pass) /
# 1 (fail). No arguments. Three checks on the live editor config entity:
#   item — "template" is present in settings.toolbar.items
#   cfg  — settings.plugins.ckeditor5_template_template exists with a non-empty file_path
#   file — that file_path resolves to a real file on disk (the plugin validates this too)
set -uo pipefail
cd /var/www/html

out=$(drush php:eval '
  $e = \Drupal\editor\Entity\Editor::load("full_html");
  $s = $e ? $e->getSettings() : [];
  $item = isset($s["toolbar"]["items"]) && in_array("template", $s["toolbar"]["items"], TRUE);
  $p = $s["plugins"]["ckeditor5_template_template"] ?? NULL;
  $path = is_array($p) ? ($p["file_path"] ?? "") : "";
  $cfg = is_array($p) && $path !== "";
  $file = $cfg && file_exists(DRUPAL_ROOT . $path);
  print (($item && $cfg && $file) ? "PASS" : "FAIL")
    . " item=" . ($item?1:0) . " cfg=" . ($cfg?1:0) . " file=" . ($file?1:0)
    . " file_path=" . $path . "\n";
' 2>/dev/null)

echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
