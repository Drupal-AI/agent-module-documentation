#!/usr/bin/env bash
# Execution VERIFY: PASS when media type mpb_dash exists, uses source media_power_bi, and its
# configured source field is a string_long field. Prints PASS/FAIL; exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $mt = \Drupal\media\Entity\MediaType::load("mpb_dash");
  if (!$mt) { print "FAIL media_type=missing\n"; return; }
  $src = $mt->getSource()->getPluginId();
  $sf = $mt->getSource()->getConfiguration()["source_field"] ?? "";
  $ftype = "none";
  if ($sf && ($fs = \Drupal\field\Entity\FieldStorageConfig::loadByName("media", $sf))) { $ftype = $fs->getType(); }
  $ok = ($src === "media_power_bi") && ($ftype === "string_long");
  print ($ok ? "PASS" : "FAIL") . " source=" . $src . " source_field=" . $sf . " field_type=" . $ftype . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
