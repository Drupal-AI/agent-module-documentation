#!/usr/bin/env bash
# Execution VERIFY (tzfield create): PASS when field_tz_new exists on Article as a tzfield
# (storage type tzfield + a FieldConfig on the article bundle). exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  $fs = FieldStorageConfig::loadByName("node","field_tz_new");
  $fc = FieldConfig::loadByName("node","article","field_tz_new");
  $type = $fs ? $fs->getType() : "none";
  $ok = ($fs && $type === "tzfield" && $fc);
  print ($ok ? "PASS" : "FAIL") . " storage_type=" . $type . " field_on_article=" . ($fc ? "yes" : "no") . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
