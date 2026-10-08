#!/usr/bin/env bash
# Execution VERIFY: PASS when field_fdl_task on Article carries field_display_label display_label
# == 'Rendered Title'. Exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\field\Entity\FieldConfig;
  $fc = FieldConfig::loadByName("node", "article", "field_fdl_task");
  $val = $fc ? $fc->getThirdPartySetting("field_display_label", "display_label") : NULL;
  $ok = ($val === "Rendered Title");
  print ($ok ? "PASS" : "FAIL") . " display_label=" . var_export($val, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
