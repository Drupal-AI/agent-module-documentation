#!/usr/bin/env bash
# Execution VERIFY: PASS when the 'title' widget of view vefl_bef_assign is in the 'middle' region.
# exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $c = \Drupal::config("views.view.vefl_bef_assign");
  $wr = $c->get("display.default.display_options.exposed_form.options.layout.widget_region") ?: [];
  $region = $wr["title"] ?? NULL;
  print (($region === "middle") ? "PASS" : "FAIL") . " title_region=" . var_export($region, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
