#!/usr/bin/env bash
# Execution VERIFY: PASS when the layout_builder__translation FieldConfig exists on node.page
# (auto-created by layout_builder_st when overrides are enabled).
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\field\Entity\FieldConfig;
  $f = FieldConfig::loadByName("node","page","layout_builder__translation");
  $ok = (bool) $f;
  print ($ok ? "PASS" : "FAIL") . " layout_builder__translation=" . ($ok ? "present" : "absent") . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
