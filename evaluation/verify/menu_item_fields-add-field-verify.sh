#!/usr/bin/env bash
# Execution VERIFY: PASS when a FieldConfig field_mif_task exists on bundle menu_link_content.
# Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\field\Entity\FieldConfig;
  $fc = FieldConfig::loadByName("menu_link_content", "menu_link_content", "field_mif_task");
  $ok = (bool) $fc;
  print ($ok ? "PASS" : "FAIL") . " field_mif_task=" . ($fc ? $fc->getType() : "missing") . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
