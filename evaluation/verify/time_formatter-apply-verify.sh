#!/usr/bin/env bash
# Execution VERIFY: PASS when field_tf_task's default view-display component uses the
# number_time formatter with storage set to Seconds (0). exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $vd = \Drupal::service("entity_display.repository")->getViewDisplay("node","article","default");
  $c = $vd ? $vd->getComponent("field_tf_task") : NULL;
  $type = $c["type"] ?? "none";
  $storage = $c["settings"]["storage"] ?? "unset";
  $ok = ($type === "number_time" && (string)$storage === "0");
  print ($ok ? "PASS" : "FAIL") . " type=" . $type . " storage=" . var_export($storage, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
