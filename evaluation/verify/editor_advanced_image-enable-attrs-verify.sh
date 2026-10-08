#!/usr/bin/env bash
# Execution VERIFY: PASS when editor.editor.eai_task Editor Advanced Image config enables the
# title AND id attributes and sets default_class to "img-fluid". Prints PASS/FAIL. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\editor\Entity\Editor;
  $e = Editor::load("eai_task");
  $p = $e ? ($e->getSettings()["plugins"]["editor_advanced_image_image"] ?? NULL) : NULL;
  $attrs = $p["enabled_attributes"] ?? [];
  $dc = $p["default_class"] ?? "";
  $ok = in_array("title", $attrs, TRUE) && in_array("id", $attrs, TRUE) && $dc === "img-fluid";
  print ($ok ? "PASS" : "FAIL") . " attrs=" . implode(",", $attrs) . " default_class=" . var_export($dc, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
