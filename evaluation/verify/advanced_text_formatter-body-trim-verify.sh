#!/usr/bin/env bash
# SPDX-License-Identifier: GPL-2.0-or-later
# Live-state verification for the advanced_text_formatter "trim body" task.
# Prints PASS/FAIL with detail and exits 0 (pass) / 1 (fail). No arguments.
# Checks the real entity_view_display component for node.article.default body:
#   fmt   — formatter type is `advanced_text`
#   trim  — settings.trim_length is exactly 300
#   ell   — settings.ellipsis is truthy (on)
#   wb    — settings.word_boundary is truthy (on)
set -uo pipefail
cd /var/www/html

out=$(drush php:eval '
  $fmt = FALSE; $trim = FALSE; $ell = FALSE; $wb = FALSE; $type = ""; $tl = ""; $e = ""; $w = "";
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  if ($vd) {
    $c = $vd->getComponent("body");
    $type = $c["type"] ?? "";
    $s = $c["settings"] ?? [];
    $tl = $s["trim_length"] ?? "";
    $e  = $s["ellipsis"] ?? "";
    $w  = $s["word_boundary"] ?? "";
    if ($type === "advanced_text") { $fmt = TRUE; }
    if ((int) $tl === 300) { $trim = TRUE; }
    if (!empty($e)) { $ell = TRUE; }
    if (!empty($w)) { $wb = TRUE; }
  }
  $ok = $fmt && $trim && $ell && $wb;
  print ($ok ? "PASS" : "FAIL") . " fmt=" . ($fmt?1:0) . " trim=" . ($trim?1:0) . " ell=" . ($ell?1:0) . " wb=" . ($wb?1:0) . " type=" . $type . " trim_length=" . $tl . " ellipsis=" . $e . " word_boundary=" . $w . "\n";
' 2>/dev/null)

echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
