#!/usr/bin/env bash
# Execution VERIFY: PASS when addtocal is enabled on field_atc_loc's formatter AND its event
# location setting == "Main Hall" AND label == "Add to my calendar". exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $c = $vd ? $vd->getComponent("field_atc_loc") : NULL;
  $inst = $c["third_party_settings"]["date_augmenter"]["instances"] ?? [];
  $st = $inst["status"]["addtocal"] ?? NULL;
  $loc = $inst["settings"]["addtocal"]["location"] ?? NULL;
  $lab = $inst["settings"]["addtocal"]["label"] ?? NULL;
  $ok = ($st === TRUE && $loc === "Main Hall" && $lab === "Add to my calendar");
  print ($ok ? "PASS" : "FAIL") . " status=" . var_export($st, TRUE) . " location=" . var_export($loc, TRUE) . " label=" . var_export($lab, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
