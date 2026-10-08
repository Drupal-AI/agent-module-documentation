#!/usr/bin/env bash
# Execution VERIFY: PASS when view vefl_task exposed form uses the vefl_basic style with the
# vefl_onecol layout. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $c = \Drupal::config("views.view.vefl_task");
  $t = $c->get("display.default.display_options.exposed_form.type");
  $l = $c->get("display.default.display_options.exposed_form.options.layout.layout_id");
  $ok = ($t === "vefl_basic" && $l === "vefl_onecol");
  print ($ok ? "PASS" : "FAIL") . " type=" . var_export($t, TRUE) . " layout=" . var_export($l, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
