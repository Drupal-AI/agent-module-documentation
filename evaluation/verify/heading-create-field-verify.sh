#!/usr/bin/env bash
# Execution VERIFY: PASS when Article has a field field_hdg_task whose field type is 'heading'.
# Exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\field\Entity\FieldConfig;
  $fc = FieldConfig::loadByName("node","article","field_hdg_task");
  $type = $fc ? $fc->getType() : "none";
  $ok = ($type === "heading");
  print ($ok ? "PASS" : "FAIL") . " type=" . $type . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
