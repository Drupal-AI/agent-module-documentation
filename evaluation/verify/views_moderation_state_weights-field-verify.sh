#!/usr/bin/env bash
# Execution VERIFY (field): PASS when view vmsw_fview has a FIELD handler using the module's
# moderation_state_weight field on some display. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\views\Entity\View;
  $v = View::load("vmsw_fview");
  if (!$v) { print "FAIL no-view\n"; return; }
  $found = FALSE;
  foreach ($v->get("display") as $disp) {
    foreach ($disp["display_options"]["fields"] ?? [] as $f) {
      if (($f["plugin_id"] ?? "") === "moderation_state_weight_field" || ($f["field"] ?? "") === "moderation_state_weight") { $found = TRUE; }
    }
  }
  print ($found ? "PASS" : "FAIL") . " view=vmsw_fview weight_field=" . ($found ? "yes" : "no") . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
