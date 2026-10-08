#!/usr/bin/env bash
# Execution VERIFY: PASS when a Duration field field_df_period exists on Article with granularity
# 'y:m', AND its default view display uses the Human Friendly formatter (duration_human_display)
# with text_length 'short'. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  $fs = FieldStorageConfig::loadByName("node", "field_df_period");
  $fc = FieldConfig::loadByName("node", "article", "field_df_period");
  $gran = $fc ? $fc->getSetting("granularity") : "";
  $comp = \Drupal::service("entity_display.repository")->getViewDisplay("node", "article")->getComponent("field_df_period");
  $ftype = $comp["type"] ?? "";
  $tlen = $comp["settings"]["text_length"] ?? "";
  $ok = ($fs && $fs->getType() === "duration" && $fc && $gran === "y:m" && $ftype === "duration_human_display" && $tlen === "short");
  print ($ok ? "PASS" : "FAIL") . " type=" . var_export($fs ? $fs->getType() : "", TRUE) . " gran=" . var_export($gran, TRUE) . " fmt=" . var_export($ftype, TRUE) . " len=" . var_export($tlen, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
