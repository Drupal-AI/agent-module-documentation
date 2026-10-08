#!/usr/bin/env bash
# Execution VERIFY: PASS when responsive_300w, responsive_600w and responsive_900w all exist as
# image styles, each with an image_scale effect at the matching width. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\image\Entity\ImageStyle;
  $ok = TRUE; $seen = [];
  foreach ([300 => "responsive_300w", 600 => "responsive_600w", 900 => "responsive_900w"] as $w => $n) {
    $s = ImageStyle::load($n);
    if (!$s) { $ok = FALSE; continue; }
    $has = FALSE;
    foreach ($s->getEffects() as $e) {
      $cfg = $e->getConfiguration();
      if ($e->getPluginId() === "image_scale" && (int) ($cfg["data"]["width"] ?? 0) === $w) { $has = TRUE; }
    }
    $seen[] = $n . ($has ? "(scale:$w)" : "(no-effect)");
    if (!$has) { $ok = FALSE; }
  }
  print ($ok ? "PASS" : "FAIL") . " " . implode(",", $seen) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
