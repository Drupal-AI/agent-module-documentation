#!/usr/bin/env bash
# Execution VERIFY: PASS when the live prepopulate.populator service's whitelist contains the
# "radios" element type (i.e. a hook_prepopulate_whitelist_alter() implementation is registered
# and effective). Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $s = \Drupal::service("prepopulate.populator");
  $p = (new ReflectionClass($s))->getProperty("whitelistedTypes"); $p->setAccessible(TRUE);
  $types = $p->getValue($s);
  $ok = in_array("radios", $types, TRUE);
  print ($ok ? "PASS" : "FAIL") . " count=" . count($types) . " types=" . implode(",", $types) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
