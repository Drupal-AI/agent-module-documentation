#!/usr/bin/env bash
# Execution VERIFY: PASS when snapshot cs_task2.module.cs_task2mod exists and its default
# collection stores BOTH config objects 'cs_task2.a' and 'cs_task2.b'.
# Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $e = Drupal\config_snapshot\Entity\ConfigSnapshot::load("cs_task2.module.cs_task2mod");
  $a = $e ? $e->getItem("", "cs_task2.a") : NULL;
  $b = $e ? $e->getItem("", "cs_task2.b") : NULL;
  $ok = is_array($a) && is_array($b);
  print ($ok ? "PASS" : "FAIL") . " a=" . var_export($a["name"] ?? NULL, TRUE) . " b=" . var_export($b["name"] ?? NULL, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
