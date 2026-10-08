#!/usr/bin/env bash
# Execution VERIFY: PASS when a pagerer_preset 'pgr_task' exists whose center pane uses the
# 'progressive' style. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $p = \Drupal::entityTypeManager()->getStorage("pagerer_preset")->load("pgr_task");
  if (!$p) { print "FAIL no-preset\n"; return; }
  $panes = $p->get("panes");
  $center = $panes["center"]["style"] ?? "none";
  print ((($center === "progressive") ? "PASS" : "FAIL")." center=".$center."\n");
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
