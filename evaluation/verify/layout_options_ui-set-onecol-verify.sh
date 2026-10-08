#!/usr/bin/env bash
# Execution VERIFY: PASS when layout_options.settings layout_overrides marks
# layout_discovery__layout_onecol as enabled (== 1). exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $o = \Drupal::config("layout_options.settings")->get("layout_overrides");
  $o = is_array($o) ? $o : [];
  $v = $o["layout_discovery__layout_onecol"] ?? NULL;
  $ok = ($v == 1);
  print ($ok ? "PASS" : "FAIL") . " layout_discovery__layout_onecol=" . var_export($v, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
