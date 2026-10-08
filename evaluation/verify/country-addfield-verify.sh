#!/usr/bin/env bash
# Execution VERIFY: PASS when node.article has a country field_ctry_task restricted to CA and MX. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\field\Entity\FieldConfig;
  $fc = FieldConfig::loadByName("node","article","field_ctry_task");
  $type = $fc ? $fc->getType() : "none";
  $sel = $fc ? ($fc->getSetting("selectable_countries") ?: []) : [];
  sort($sel);
  $ok = ($type === "country" && $sel === ["CA","MX"]);
  print ($ok ? "PASS" : "FAIL") . " type=$type sel=" . implode(",", $sel) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
