#!/usr/bin/env bash
# Execution VERIFY: PASS when field_tf_switch still uses number_time AND its hours setting is
# Never (2). exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $vd = \Drupal::service("entity_display.repository")->getViewDisplay("node","article","default");
  $c = $vd ? $vd->getComponent("field_tf_switch") : NULL;
  $type = $c["type"] ?? "none";
  $hours = $c["settings"]["hours"] ?? "unset";
  $ok = ($type === "number_time" && (string)$hours === "2");
  print ($ok ? "PASS" : "FAIL") . " type=" . $type . " hours=" . var_export($hours, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
