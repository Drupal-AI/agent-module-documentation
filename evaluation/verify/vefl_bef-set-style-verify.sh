#!/usr/bin/env bash
# Execution VERIFY: PASS when view vefl_bef_task uses exposed form type vefl_bef with vefl_onecol.
# exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $c = \Drupal::config("views.view.vefl_bef_task");
  $t = $c->get("display.default.display_options.exposed_form.type");
  $l = $c->get("display.default.display_options.exposed_form.options.layout.layout_id");
  $ok = ($t === "vefl_bef" && $l === "vefl_onecol");
  print ($ok ? "PASS" : "FAIL") . " type=" . var_export($t, TRUE) . " layout=" . var_export($l, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
