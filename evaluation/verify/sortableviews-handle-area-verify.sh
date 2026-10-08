#!/usr/bin/env bash
# Execution VERIFY: PASS when sortableviews_ha's default display has a field using plugin
# sortable_views_handle AND a header/footer area using plugin save_sortable_changes. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\views\Entity\View;
  $v = View::load("sortableviews_ha");
  $has_handle = FALSE; $has_save = FALSE;
  if ($v) {
    $o = $v->get("display")["default"]["display_options"];
    foreach (($o["fields"] ?? []) as $f) { if (($f["plugin_id"] ?? "") === "sortable_views_handle") { $has_handle = TRUE; } }
    foreach (["header","footer"] as $area) {
      foreach (($o[$area] ?? []) as $a) { if (($a["plugin_id"] ?? "") === "save_sortable_changes") { $has_save = TRUE; } }
    }
  }
  $ok = ($has_handle && $has_save);
  print ($ok ? "PASS" : "FAIL") . " handle=" . ($has_handle ? "yes" : "no") . " save_area=" . ($has_save ? "yes" : "no") . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
