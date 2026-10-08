#!/usr/bin/env bash
# Execution VERIFY (field): PASS when view vab_fview has a views_add_button_field field handler on
# some display. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\views\Entity\View;
  $v = View::load("vab_fview");
  if (!$v) { print "FAIL no-view\n"; return; }
  $found = FALSE;
  foreach ($v->get("display") as $disp) {
    foreach ($disp["display_options"]["fields"] ?? [] as $f) {
      if (($f["plugin_id"] ?? "") === "views_add_button_field" || ($f["field"] ?? "") === "views_add_button_field") { $found = TRUE; }
    }
  }
  print ($found ? "PASS" : "FAIL") . " view=vab_fview add_button_field=" . ($found ? "yes" : "no") . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
