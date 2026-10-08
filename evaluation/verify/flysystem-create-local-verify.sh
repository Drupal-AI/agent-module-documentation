#!/usr/bin/env bash
# Execution VERIFY: PASS when the flysystem_factory reports a scheme 'flytask' whose driver
# is 'local'. Prints PASS/FAIL. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $f = \Drupal::service("flysystem_factory");
  $has = in_array("flytask", $f->getSchemes(), TRUE);
  $driver = $has ? ($f->getSettings("flytask")["driver"] ?? "") : "";
  $ok = ($has && $driver === "local");
  print ($ok ? "PASS" : "FAIL") . " has=" . var_export($has, TRUE) . " driver=" . var_export($driver, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
