#!/usr/bin/env bash
# Execution VERIFY: PASS when the addtocal Date Augmenter is ENABLED on field_atc_task's formatter
# in node.article.default (third_party_settings.date_augmenter.instances.status.addtocal === TRUE).
# Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $c = $vd ? $vd->getComponent("field_atc_task") : NULL;
  $st = $c["third_party_settings"]["date_augmenter"]["instances"]["status"]["addtocal"] ?? NULL;
  $ok = ($st === TRUE);
  print ($ok ? "PASS" : "FAIL") . " addtocal_status=" . var_export($st, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
