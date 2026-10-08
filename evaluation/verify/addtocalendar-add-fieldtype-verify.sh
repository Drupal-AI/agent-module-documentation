#!/usr/bin/env bash
# Execution VERIFY: PASS when Article has a field field_atc_btn whose storage type is
# add_to_calendar_field. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  $fs = FieldStorageConfig::loadByName("node", "field_atc_btn");
  $fc = FieldConfig::loadByName("node", "article", "field_atc_btn");
  $type = $fs ? $fs->getType() : "none";
  $ok = ($fs && $fc && $type === "add_to_calendar_field");
  print ($ok ? "PASS" : "FAIL") . " type=" . $type . " instance=" . ($fc ? "yes" : "no") . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
