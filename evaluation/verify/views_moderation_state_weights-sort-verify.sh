#!/usr/bin/env bash
# Execution VERIFY (sort): PASS when view vmsw_sview has a SORT handler using the module's
# moderation_state_weight sort on some display. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\views\Entity\View;
  $v = View::load("vmsw_sview");
  if (!$v) { print "FAIL no-view\n"; return; }
  $found = FALSE;
  foreach ($v->get("display") as $disp) {
    foreach ($disp["display_options"]["sorts"] ?? [] as $s) {
      if (($s["plugin_id"] ?? "") === "moderation_state_weight_sort" || ($s["field"] ?? "") === "moderation_state_weight") { $found = TRUE; }
    }
  }
  print ($found ? "PASS" : "FAIL") . " view=vmsw_sview weight_sort=" . ($found ? "yes" : "no") . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
