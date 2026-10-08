#!/usr/bin/env bash
# Execution VERIFY: PASS when field_caa_rm carries custom_add_another.custom_remove ===
# 'Remove this highlight'. Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $fc = \Drupal\field\Entity\FieldConfig::loadByName("node","caa_rm","field_caa_rm");
  $v = $fc ? $fc->getThirdPartySetting("custom_add_another","custom_remove") : NULL;
  $ok = ($v === "Remove this highlight");
  print ($ok ? "PASS" : "FAIL") . " value=" . var_export($v, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
