#!/usr/bin/env bash
# Execution VERIFY: PASS when filter.format.mee_ready has media_embed enabled and its
# filter_html allowed_html permits <drupal-media ...> with data-width AND data-height.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\filter\Entity\FilterFormat;
  $f = FilterFormat::load("mee_ready");
  $ok = FALSE; $me = FALSE; $dw = FALSE; $dh = FALSE;
  if ($f) {
    $me = (bool) $f->filters("media_embed")->status;
    $ah = $f->filters("filter_html")->status ? ($f->filters("filter_html")->settings["allowed_html"] ?? "") : "";
    $hasMedia = strpos($ah, "<drupal-media") !== FALSE;
    $dw = $hasMedia && strpos($ah, "data-width") !== FALSE;
    $dh = $hasMedia && strpos($ah, "data-height") !== FALSE;
    $ok = $me && $dw && $dh;
  }
  print ($ok ? "PASS" : "FAIL") . " media_embed=" . var_export($me, TRUE) . " data-width=" . var_export($dw, TRUE) . " data-height=" . var_export($dh, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
