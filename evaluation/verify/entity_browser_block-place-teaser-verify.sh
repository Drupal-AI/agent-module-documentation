#!/usr/bin/env bash
# Live-state verification for "Entity Browser Block: node:1 as teaser in olivero content".
# Prints PASS/FAIL with detail and exits 0 (pass) / 1 (fail). No arguments.
# Scans block.block config entities for one that:
#   plg — plugin id starts with entity_browser_block: (derived from an Entity Browser)
#   loc — theme olivero, region content
#   ent — settings.entity_ids contains "node:1"
#   vm  — settings.view_modes["node:1"] === "teaser"
set -uo pipefail
cd /var/www/html

out=$(drush php:eval '
  $plg=$loc=$ent=$vm=FALSE; $detail="none";
  foreach (\Drupal\block\Entity\Block::loadMultiple() as $b) {
    if (!str_starts_with($b->getPluginId(), "entity_browser_block:")) { continue; }
    $plg = TRUE;
    $s = $b->get("settings");
    $ids = $s["entity_ids"] ?? [];
    $vms = $s["view_modes"] ?? [];
    $l = ($b->getTheme() === "olivero" && $b->getRegion() === "content");
    $e = in_array("node:1", $ids, TRUE);
    $v = (($vms["node:1"] ?? NULL) === "teaser");
    if ($l && $e && $v) {
      $loc=$ent=$vm=TRUE;
      $detail = "block=" . $b->id() . " plugin=" . $b->getPluginId();
      break;
    }
    $detail = "block=" . $b->id() . " theme=" . $b->getTheme() . " region=" . $b->getRegion()
      . " ids=" . implode(",", $ids) . " vm=" . json_encode($vms);
  }
  $ok = $plg && $loc && $ent && $vm;
  print ($ok ? "PASS" : "FAIL") . " plg=" . ($plg?1:0) . " loc=" . ($loc?1:0)
    . " ent=" . ($ent?1:0) . " vm=" . ($vm?1:0) . " " . $detail . "\n";
' 2>/dev/null)

echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
