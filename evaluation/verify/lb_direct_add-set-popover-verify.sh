#!/usr/bin/env bash
# Execution VERIFY: PASS when lb_direct_add is configured as a popover menu (use_label=1) with
# label exactly 'Add widget'. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $c = \Drupal::config("lb_direct_add.settings");
  $ok = ((int) $c->get("use_label") === 1) && ($c->get("label") === "Add widget");
  print ($ok ? "PASS" : "FAIL") . " use_label=" . var_export($c->get("use_label"), TRUE) . " label=" . var_export($c->get("label"), TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
