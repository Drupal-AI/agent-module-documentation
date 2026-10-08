#!/usr/bin/env bash
# Execution VERIFY: PASS when a snapshot cs_task.module.cs_taskmod exists and its default
# collection stores config object 'cs_task.demo' with data ['flag' => true].
# Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $e = Drupal\config_snapshot\Entity\ConfigSnapshot::load("cs_task.module.cs_taskmod");
  $item = $e ? $e->getItem("", "cs_task.demo") : NULL;
  $data = $item["data"] ?? NULL;
  $ok = is_array($data) && (($data["flag"] ?? NULL) === TRUE || ($data["flag"] ?? NULL) === 1 || ($data["flag"] ?? NULL) === "1");
  print ($ok ? "PASS" : "FAIL") . " data=" . var_export($data, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
