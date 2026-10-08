#!/usr/bin/env bash
# Execution VERIFY (hours_minutes_seconds): PASS when field_hms_show's component in
# core.entity_view_display.node.article.default uses the countdown timer formatter.
# exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $c = $vd ? $vd->getComponent("field_hms_show") : NULL;
  $type = $c["type"] ?? "none";
  $ok = ($type === "hour_minutes_seconds_countdown_formatter");
  print ($ok?"PASS":"FAIL")." type=".$type."\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
