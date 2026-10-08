#!/usr/bin/env bash
# Execution VERIFY: PASS when FieldConfig field_miu_task exists on bundle menu_link_content.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\field\Entity\FieldConfig;
  $fc = FieldConfig::loadByName("menu_link_content", "menu_link_content", "field_miu_task");
  print (($fc) ? "PASS" : "FAIL") . " field_miu_task=" . ($fc ? $fc->getType() : "missing") . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
