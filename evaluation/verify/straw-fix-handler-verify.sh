#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\field\Entity\FieldConfig;
  $fc = FieldConfig::loadByName("node","article","field_straw_fix");
  $h = $fc ? $fc->getSetting("handler") : "none";
  print (($h === "straw") ? "PASS" : "FAIL") . " handler=$h";
' 2>/dev/null)
echo "$out"; echo "$out" | grep -q '^PASS' && exit 0 || exit 1
