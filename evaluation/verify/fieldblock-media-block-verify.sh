#!/usr/bin/env bash
# Execution VERIFY: PASS when (a) fieldblock.settings enables the media entity type, (b) the
# fieldblock:media block derivative really exists in the live block plugin definitions, and
# (c) block fieldblock_task_media renders the media Name field with the string formatter in
# Olivero's sidebar. Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\block\Entity\Block;
  $enabled = \Drupal::config("fieldblock.settings")->get("enabled_entity_types") ?: [];
  $has_media_type = in_array("media", array_filter($enabled), TRUE);
  $defs = \Drupal::service("plugin.manager.block")->getDefinitions();
  $has_derivative = isset($defs["fieldblock:media"]);
  $b = Block::load("fieldblock_task_media");
  $s = $b ? $b->get("settings") : [];
  $ok = $has_media_type && $has_derivative && $b
    && $b->get("plugin") === "fieldblock:media"
    && $b->getTheme() === "olivero"
    && $b->getRegion() === "sidebar"
    && ($s["field_name"] ?? NULL) === "name"
    && ($s["formatter_id"] ?? NULL) === "string";
  print ($ok ? "PASS" : "FAIL")
    . " enabled=" . implode("|", array_filter($enabled))
    . " derivative=" . ($has_derivative ? "yes" : "no")
    . " block=" . ($b ? $b->get("plugin") : "none")
    . " region=" . ($b ? $b->getRegion() : "none")
    . " field=" . ($s["field_name"] ?? "none")
    . " formatter=" . ($s["formatter_id"] ?? "none") . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
