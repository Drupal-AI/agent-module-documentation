#!/usr/bin/env bash
# Execution VERIFY: PASS when field_vms instance allowed_view_modes contains 'full' (and still
# 'teaser'). exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\field\Entity\FieldConfig;
  $fc = FieldConfig::loadByName("node","article","field_vms");
  $allowed = $fc ? array_keys(array_filter($fc->getSetting("allowed_view_modes") ?: [])) : [];
  $ok = (in_array("full", $allowed, TRUE) && in_array("teaser", $allowed, TRUE));
  print ($ok ? "PASS" : "FAIL") . " allowed=[" . implode(",", $allowed) . "]\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
