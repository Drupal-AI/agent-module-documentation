#!/usr/bin/env bash
# Execution VERIFY: PASS when field_atc_task's component in core.entity_view_display.node.article.default
# carries third_party_settings.addtocalendar.addtocalendar_show truthy. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $c = $vd ? $vd->getComponent("field_atc_task") : NULL;
  $show = $c["third_party_settings"]["addtocalendar"]["addtocalendar_show"] ?? NULL;
  $ok = !empty($show);
  print ($ok ? "PASS" : "FAIL") . " show=" . var_export($show, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
