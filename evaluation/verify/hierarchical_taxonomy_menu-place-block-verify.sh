#!/usr/bin/env bash
# Execution VERIFY: PASS when some block uses the hierarchical_taxonomy_menu plugin with its
# vocabulary set to 'tags'. Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $found = "none";
  foreach (\Drupal::entityTypeManager()->getStorage("block")->loadMultiple() as $b) {
    if ($b->getPluginId() === "hierarchical_taxonomy_menu" && (($b->get("settings")["vocabulary"] ?? "") === "tags")) { $found = $b->id(); break; }
  }
  $ok = ($found !== "none");
  print ($ok?"PASS":"FAIL")." block=".$found."\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
