#!/usr/bin/env bash
# Execution VERIFY: PASS when a field named field_spt of type scheduled_publish exists on the
# Article content type (storage + bundle field). exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  $fs = FieldStorageConfig::loadByName("node","field_spt");
  $fc = FieldConfig::loadByName("node","article","field_spt");
  $type = $fs ? $fs->getType() : "none";
  $ok = ($fs && $fc && $type === "scheduled_publish");
  print ($ok ? "PASS" : "FAIL") . " type=" . $type . " bundle_field=" . ($fc ? "1" : "0") . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
