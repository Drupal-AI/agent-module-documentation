#!/usr/bin/env bash
# Execution VERIFY: PASS when lb_direct_add is configured as the default dropbutton
# (use_label=0). exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $c = \Drupal::config("lb_direct_add.settings");
  $ok = ((int) $c->get("use_label") === 0);
  print ($ok ? "PASS" : "FAIL") . " use_label=" . var_export($c->get("use_label"), TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
