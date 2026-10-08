#!/usr/bin/env bash
# Execution VERIFY: PASS when field_ufo_task exists on node.article as a list_string field with at
# least two allowed values whose keys are ALL URL-friendly (module regex ^[a-zA-Z0-9-]*[a-zA-Z0-9]+$).
# Prints PASS/FAIL; exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  $fs = FieldStorageConfig::loadByName("node", "field_ufo_task");
  if (!$fs || $fs->getType() !== "list_string") { print "FAIL missing-or-wrong-type\n"; return; }
  $vals = $fs->getSetting("allowed_values") ?: [];
  $keys = array_keys($vals);
  $all_ok = !empty($keys);
  foreach ($keys as $k) {
    if (!preg_match("/^[a-zA-Z0-9-]*[a-zA-Z0-9]+$/", (string) $k)) { $all_ok = FALSE; }
  }
  $ok = $all_ok && count($keys) >= 2;
  print ($ok ? "PASS" : "FAIL") . " keys=" . json_encode($keys) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
