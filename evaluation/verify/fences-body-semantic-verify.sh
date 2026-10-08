#!/usr/bin/env bash
# SPDX-License-Identifier: GPL-2.0-or-later
# Live-state verification for the fences "semantic body markup" task.
# Prints PASS/FAIL with detail and exits 0 (pass) / 1 (fail). No arguments.
# Checks real entity_view_display third_party_settings.fences on node.article.default body:
#   ftag  — fences_field_tag is exactly `article`
#   fcls  — fences_field_classes contains `node-body`
#   ltag  — fences_label_tag is exactly `h2`
set -uo pipefail
cd /var/www/html

out=$(drush php:eval '
  $ftag = FALSE; $fcls = FALSE; $ltag = FALSE; $t = ""; $cl = ""; $l = "";
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  if ($vd) {
    $c = $vd->getComponent("body");
    $f = $c["third_party_settings"]["fences"] ?? [];
    $t  = $f["fences_field_tag"] ?? "";
    $cl = $f["fences_field_classes"] ?? "";
    $l  = $f["fences_label_tag"] ?? "";
    if ($t === "article") { $ftag = TRUE; }
    if (strpos($cl, "node-body") !== FALSE) { $fcls = TRUE; }
    if ($l === "h2") { $ltag = TRUE; }
  }
  $ok = $ftag && $fcls && $ltag;
  print ($ok ? "PASS" : "FAIL") . " ftag=" . ($ftag?1:0) . " fcls=" . ($fcls?1:0) . " ltag=" . ($ltag?1:0) . " fences_field_tag=" . $t . " fences_field_classes=" . $cl . " fences_label_tag=" . $l . "\n";
' 2>/dev/null)

echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
