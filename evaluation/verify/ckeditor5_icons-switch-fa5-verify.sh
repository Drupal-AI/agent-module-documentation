#!/usr/bin/env bash
# Execution VERIFY for "switch the ckeditor5_icons_legacy format's icon picker to Font Awesome 5
# with only the Solid and Brands styles".
# PASS when editor.editor.ckeditor5_icons_legacy still has `icon` in the toolbar and
# settings.plugins.ckeditor5_icons_icon has fa_version '5' and fa_styles exactly [brands, solid]
# (order-insensitive). Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\editor\Entity\Editor;
  $e = Editor::load("ckeditor5_icons_legacy");
  $s = $e ? $e->getSettings() : [];
  $items = $s["toolbar"]["items"] ?? [];
  $cfg = $s["plugins"]["ckeditor5_icons_icon"] ?? NULL;
  $styles = $cfg["fa_styles"] ?? [];
  sort($styles);
  $ok = in_array("icon", $items, TRUE)
    && is_array($cfg)
    && (string) ($cfg["fa_version"] ?? "") === "5"
    && $styles === ["brands", "solid"];
  print ($ok ? "PASS" : "FAIL")
    . " toolbar_icon=" . (in_array("icon", $items, TRUE) ? "yes" : "no")
    . " fa_version=" . var_export($cfg["fa_version"] ?? NULL, TRUE)
    . " fa_styles=[" . implode(",", $styles) . "]\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
