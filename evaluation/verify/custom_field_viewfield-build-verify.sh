#!/usr/bin/env bash
# Execution VERIFY (custom_field_viewfield): PASS when a Custom Field field_cf_vf exists on node
# and its storage columns include at least one column of type "viewfield". exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $fs = \Drupal\field\Entity\FieldStorageConfig::loadByName("node","field_cf_vf");
  $type = $fs ? $fs->getType() : "none";
  $cols = $fs ? ($fs->getSetting("columns") ?? []) : [];
  $has = FALSE; $names = [];
  foreach ($cols as $n => $c) { $names[] = $n.":".($c["type"]??"?"); if (($c["type"]??"") === "viewfield") $has = TRUE; }
  $ok = ($type === "custom" && $has);
  print ($ok ? "PASS" : "FAIL") . " field_type=" . $type . " columns=[" . implode(",", $names) . "]\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q "^PASS" && exit 0 || exit 1
