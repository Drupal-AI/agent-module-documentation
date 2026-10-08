#!/usr/bin/env bash
# Execution VERIFY: PASS when vri_reconfig_view default display row_insert style has
# rows_number == 5 AND row_header truthy.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\views\Entity\View;
  $v = View::load("vri_reconfig_view");
  $o = $v ? ($v->getDisplay("default")["display_options"]["style"]["options"] ?? []) : [];
  $rn = (int) ($o["rows_number"] ?? 0);
  $rh = !empty($o["row_header"]);
  $ok = ($rn === 5 && $rh);
  print ($ok ? "PASS" : "FAIL") . " rows_number=" . $rn . " row_header=" . var_export($rh, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
