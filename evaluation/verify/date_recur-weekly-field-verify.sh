#!/usr/bin/env bash
# Live-state verification for the "weekly-only recurring date field on Article" task.
# Prints PASS/FAIL with detail and exits 0 (pass) / 1 (fail). No arguments.
# Three independent checks against real site config:
#   fld — node.article has a field field_eval_recur
#   typ — that field (and its storage) is of type `date_recur`
#   wkly — the field's parts grid restricts editors to the WEEKLY frequency only
#          (parts.all == FALSE, WEEKLY enabled with parts, no other frequency enabled)
set -uo pipefail
cd /var/www/html

out=$(drush php:eval '
  $fld = FALSE; $typ = FALSE; $wkly = FALSE; $detail = "";
  if ($fc = \Drupal\field\Entity\FieldConfig::loadByName("node", "article", "field_eval_recur")) {
    $fld = TRUE;
    $fcType = (string) $fc->getType();
    $fsType = "";
    if ($fs = \Drupal\field\Entity\FieldStorageConfig::loadByName("node", "field_eval_recur")) {
      $fsType = (string) $fs->getType();
    }
    if ($fcType === "date_recur" && $fsType === "date_recur") { $typ = TRUE; }
    $parts = $fc->getSetting("parts") ?: [];
    $all = !empty($parts["all"]);
    $freqs = $parts["frequencies"] ?? [];
    $enabled = [];
    foreach ($freqs as $freq => $freqParts) {
      if (is_array($freqParts) && count($freqParts) > 0) { $enabled[] = $freq; }
    }
    if (!$all && $enabled === ["WEEKLY"]) { $wkly = TRUE; }
    $detail = "fc_type=" . $fcType . " fs_type=" . $fsType . " all=" . ($all?1:0) . " enabled=" . implode(",", $enabled);
  }
  $ok = $fld && $typ && $wkly;
  print ($ok ? "PASS" : "FAIL") . " fld=" . ($fld?1:0) . " typ=" . ($typ?1:0) . " wkly=" . ($wkly?1:0) . " " . $detail . "\n";
' 2>/dev/null)

echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
