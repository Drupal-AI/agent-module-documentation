#!/usr/bin/env bash
# Execution VERIFY (area): PASS when view vab_view has a views_add_button_area handler in some
# display's header or footer. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\views\Entity\View;
  $v = View::load("vab_view");
  if (!$v) { print "FAIL no-view\n"; return; }
  $found = FALSE;
  foreach ($v->get("display") as $disp) {
    foreach (["header","footer"] as $region) {
      foreach ($disp["display_options"][$region] ?? [] as $h) {
        if (($h["plugin_id"] ?? "") === "views_add_button_area" || ($h["field"] ?? "") === "views_add_button") { $found = TRUE; }
      }
    }
  }
  print ($found ? "PASS" : "FAIL") . " view=vab_view add_button_area=" . ($found ? "yes" : "no") . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
