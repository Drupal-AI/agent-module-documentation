#!/usr/bin/env bash
# Execution VERIFY: PASS when fb_conf (facets_block) has settings add_js_classes===TRUE and
# hide_empty_block===TRUE.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\block\Entity\Block;
  $b = Block::load("fb_conf");
  $s = $b ? $b->get("settings") : [];
  $ok = $b && $b->getPluginId() === "facets_block"
        && (($s["add_js_classes"] ?? NULL) === TRUE) && (($s["hide_empty_block"] ?? NULL) === TRUE);
  print ($ok ? "PASS" : "FAIL")
    . " add_js_classes=" . var_export($s["add_js_classes"] ?? NULL, TRUE)
    . " hide_empty_block=" . var_export($s["hide_empty_block"] ?? NULL, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
