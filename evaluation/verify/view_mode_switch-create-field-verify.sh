#!/usr/bin/env bash
# Execution VERIFY: PASS when a view_mode_switch field field_vms exists on Article with
# origin_view_modes containing 'full' and allowed_view_modes containing both 'teaser' and 'full'.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig; use Drupal\field\Entity\FieldConfig;
  $fs = FieldStorageConfig::loadByName("node","field_vms");
  $fc = FieldConfig::loadByName("node","article","field_vms");
  $type = $fs ? $fs->getType() : "none";
  $origin = $fs ? array_values($fs->getSetting("origin_view_modes") ?: []) : [];
  $allowed = $fc ? array_keys(array_filter($fc->getSetting("allowed_view_modes") ?: [])) : [];
  $ok = ($type === "view_mode_switch" && in_array("full", $origin, TRUE) && in_array("teaser", $allowed, TRUE) && in_array("full", $allowed, TRUE));
  print ($ok ? "PASS" : "FAIL") . " type=" . $type . " origin=[" . implode(",", $origin) . "] allowed=[" . implode(",", $allowed) . "]\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
