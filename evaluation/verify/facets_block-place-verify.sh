#!/usr/bin/env bash
# Execution VERIFY: PASS when block fb_task exists, uses plugin facets_block, is enabled, and
# has settings add_js_classes===TRUE and show_title===FALSE.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\block\Entity\Block;
  $b = Block::load("fb_task");
  $s = $b ? $b->get("settings") : [];
  $ok = $b && $b->getPluginId() === "facets_block" && $b->status()
        && (($s["add_js_classes"] ?? NULL) === TRUE) && (($s["show_title"] ?? NULL) === FALSE);
  print ($ok ? "PASS" : "FAIL") . " plugin=" . ($b ? $b->getPluginId() : "missing")
    . " status=" . var_export($b ? $b->status() : NULL, TRUE)
    . " add_js_classes=" . var_export($s["add_js_classes"] ?? NULL, TRUE)
    . " show_title=" . var_export($s["show_title"] ?? NULL, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
