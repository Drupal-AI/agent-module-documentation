#!/usr/bin/env bash
# SPDX-License-Identifier: GPL-2.0-or-later
# Live-state verification for the "server channel for Article nodes" task.
# Prints PASS/FAIL with detail and exits 0 (pass) / 1 (fail). No arguments.
# Loads the `channel` config entity eval_channel and asserts:
#   ch    — channel eval_channel exists
#   type  — channel_entity_type is "node"
#   bndl  — channel_bundle is "article"
set -uo pipefail
cd /var/www/html

out=$(drush php:eval '
  $ch = $type = $bndl = FALSE;
  $etype = ""; $bundle = "";
  $c = \Drupal::entityTypeManager()->getStorage("channel")->load("eval_channel");
  if ($c) {
    $ch = TRUE;
    $etype = (string) $c->get("channel_entity_type");
    $bundle = (string) $c->get("channel_bundle");
    $type = ($etype === "node");
    $bndl = ($bundle === "article");
  }
  $pass = $ch && $type && $bndl;
  print ($pass ? "PASS" : "FAIL")
    . " ch=" . ($ch?1:0) . " type=" . $etype . " bundle=" . $bundle . "\n";
' 2>/dev/null)

echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
