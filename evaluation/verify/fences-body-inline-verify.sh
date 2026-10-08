#!/usr/bin/env bash
# SPDX-License-Identifier: GPL-2.0-or-later
# Live-state verification for the fences "inline body markup" task.
# Prints PASS/FAIL with detail and exits 0 (pass) / 1 (fail). No arguments.
# Checks real entity_view_display third_party_settings.fences on node.article.default body:
#   ftag  — fences_field_tag is exactly `span`
#   ltag  — fences_label_tag is exactly `none`
#   itag  — fences_field_item_tag is exactly `none`
set -uo pipefail
cd /var/www/html

out=$(drush php:eval '
  $ftag = FALSE; $ltag = FALSE; $itag = FALSE; $t = ""; $l = ""; $i = "";
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  if ($vd) {
    $c = $vd->getComponent("body");
    $f = $c["third_party_settings"]["fences"] ?? [];
    $t = $f["fences_field_tag"] ?? "";
    $l = $f["fences_label_tag"] ?? "";
    $i = $f["fences_field_item_tag"] ?? "";
    if ($t === "span") { $ftag = TRUE; }
    if ($l === "none") { $ltag = TRUE; }
    if ($i === "none") { $itag = TRUE; }
  }
  $ok = $ftag && $ltag && $itag;
  print ($ok ? "PASS" : "FAIL") . " ftag=" . ($ftag?1:0) . " ltag=" . ($ltag?1:0) . " itag=" . ($itag?1:0) . " fences_field_tag=" . $t . " fences_label_tag=" . $l . " fences_field_item_tag=" . $i . "\n";
' 2>/dev/null)

echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
