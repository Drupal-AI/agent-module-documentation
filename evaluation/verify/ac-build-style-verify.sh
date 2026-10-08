#!/usr/bin/env bash
# Execution VERIFY: PASS when image style ac_build exists and has an 'automated_crop' effect whose
# crop_type is 'freeform'. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\image\Entity\ImageStyle;
  $s = ImageStyle::load("ac_build");
  $ok = FALSE; $ct = "";
  if ($s) {
    foreach ($s->getEffects() as $e) {
      if ($e->getPluginId() === "automated_crop") {
        $ct = $e->getConfiguration()["data"]["crop_type"] ?? "";
        if ($ct === "freeform") { $ok = TRUE; }
      }
    }
  }
  print ($ok ? "PASS" : "FAIL") . " style=" . ($s ? "exists" : "missing") . " crop_type=" . $ct . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
