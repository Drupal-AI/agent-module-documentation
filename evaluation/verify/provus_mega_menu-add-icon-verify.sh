#!/usr/bin/env bash
# Execution VERIFY: PASS when field_provus_menu_icon exists on the menu_link_content 'main'
# bundle (field storage + field config). exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  $fs = (bool) FieldStorageConfig::loadByName("menu_link_content", "field_provus_menu_icon");
  $fc = (bool) FieldConfig::loadByName("menu_link_content", "main", "field_provus_menu_icon");
  $ok = ($fs && $fc);
  print ($ok ? "PASS" : "FAIL") . " storage=" . var_export($fs, TRUE) . " field=" . var_export($fc, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
