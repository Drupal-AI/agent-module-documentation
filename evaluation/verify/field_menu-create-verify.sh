#!/usr/bin/env bash
# Execution VERIFY (field_menu): PASS when a field named field_fmenu_task of type field_menu
# exists on the Article content type. Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  $fs = FieldStorageConfig::loadByName("node", "field_fmenu_task");
  $fc = FieldConfig::loadByName("node", "article", "field_fmenu_task");
  $type = $fs ? $fs->getType() : "none";
  $ok = ($fs && $fc && $type === "field_menu");
  print ($ok ? "PASS" : "FAIL") . " storage_type=" . $type . " field_on_article=" . ($fc ? "yes" : "no") . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
