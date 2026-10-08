#!/usr/bin/env bash
# SPDX-License-Identifier: GPL-2.0-or-later
# Live-state verification for the advanced_text_formatter "limit allowed HTML" task.
# Prints PASS/FAIL with detail and exits 0 (pass) / 1 (fail). No arguments.
# Checks the real entity_view_display component for node.article.default body:
#   fmt   — formatter type is `advanced_text`
#   filt  — settings.filter is exactly `limit_html`
#   tags  — settings.allowed_html permits <a>, <em>, <strong> and does NOT permit <script>
set -uo pipefail
cd /var/www/html

out=$(drush php:eval '
  $fmt = FALSE; $filt = FALSE; $tags = FALSE; $type = ""; $f = ""; $ah = "";
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  if ($vd) {
    $c = $vd->getComponent("body");
    $type = $c["type"] ?? "";
    $s = $c["settings"] ?? [];
    $f  = $s["filter"] ?? "";
    $ah = $s["allowed_html"] ?? "";
    if ($type === "advanced_text") { $fmt = TRUE; }
    if ($f === "limit_html") { $filt = TRUE; }
    if (strpos($ah, "<a>") !== FALSE && strpos($ah, "<em>") !== FALSE
        && strpos($ah, "<strong>") !== FALSE && strpos($ah, "<script>") === FALSE) { $tags = TRUE; }
  }
  $ok = $fmt && $filt && $tags;
  print ($ok ? "PASS" : "FAIL") . " fmt=" . ($fmt?1:0) . " filt=" . ($filt?1:0) . " tags=" . ($tags?1:0) . " type=" . $type . " filter=" . $f . " allowed_html=" . $ah . "\n";
' 2>/dev/null)

echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
