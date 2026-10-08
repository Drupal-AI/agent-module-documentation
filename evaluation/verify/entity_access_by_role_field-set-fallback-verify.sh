#!/usr/bin/env bash
# Execution VERIFY: PASS when field_eabrf_task on node.article has
# empty_roles_access_fallback === 'forbidden'. Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\field\Entity\FieldConfig;
  $fc = FieldConfig::loadByName("node","article","field_eabrf_task");
  $fb = $fc ? $fc->getSetting("empty_roles_access_fallback") : NULL;
  $ok = ($fb === "forbidden");
  print ($ok ? "PASS" : "FAIL") . " fallback=" . var_export($fb, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
