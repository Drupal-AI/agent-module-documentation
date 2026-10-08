#!/usr/bin/env bash
# Execution VERIFY for "enable the Icons picker on the ckeditor5_icons_task text format".
# PASS when editor.editor.ckeditor5_icons_task has:
#   - `icon` in settings.toolbar.items
#   - settings.plugins.ckeditor5_icons_icon with fa_version '6', fa_styles containing at least
#     solid and brands, recommended_enabled TRUE and recommended_icons == [drupal, heart].
# Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\editor\Entity\Editor;
  $e = Editor::load("ckeditor5_icons_task");
  $s = $e ? $e->getSettings() : [];
  $items = $s["toolbar"]["items"] ?? [];
  $cfg = $s["plugins"]["ckeditor5_icons_icon"] ?? NULL;
  $styles = $cfg["fa_styles"] ?? [];
  $rec = $cfg["recommended_icons"] ?? [];
  sort($rec);
  $ok = in_array("icon", $items, TRUE)
    && is_array($cfg)
    && (string) ($cfg["fa_version"] ?? "") === "6"
    && in_array("solid", $styles, TRUE)
    && in_array("brands", $styles, TRUE)
    && !empty($cfg["recommended_enabled"])
    && $rec === ["drupal", "heart"];
  print ($ok ? "PASS" : "FAIL")
    . " toolbar_icon=" . (in_array("icon", $items, TRUE) ? "yes" : "no")
    . " fa_version=" . var_export($cfg["fa_version"] ?? NULL, TRUE)
    . " fa_styles=[" . implode(",", $styles) . "]"
    . " recommended_enabled=" . var_export($cfg["recommended_enabled"] ?? NULL, TRUE)
    . " recommended_icons=[" . implode(",", $rec) . "]\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
