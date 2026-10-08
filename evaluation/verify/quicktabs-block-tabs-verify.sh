#!/usr/bin/env bash
# Live-state verification for the "build a Quick Tabs instance that uses the
# accordion_tabs renderer with two block_content tabs" execution task.
# Prints PASS/FAIL with detail and exits 0 (pass) / 1 (fail). PASS only if the
# quicktabs_instance `eval_block_tabs` exists AND uses renderer accordion_tabs AND
# has at least two tabs, all of type block_content.
set -uo pipefail
cd /var/www/html

out=$(drush php:eval '
  $qt = \Drupal::entityTypeManager()->getStorage("quicktabs_instance")->load("eval_block_tabs");
  $exists = (bool) $qt;
  $tabs = ($exists && is_array($qt->getConfigurationData())) ? $qt->getConfigurationData() : [];
  $count = count($tabs);
  $renderer = $exists ? (string) $qt->getRenderer() : "";
  $all_block = $count > 0;
  foreach ($tabs as $t) {
    if (($t["type"] ?? "") !== "block_content") { $all_block = FALSE; }
  }
  $ok = $exists && $renderer === "accordion_tabs" && $count >= 2 && $all_block;
  print ($ok ? "PASS" : "FAIL")
    . " exists=" . ($exists ? 1 : 0)
    . " tabs=" . $count
    . " renderer=" . $renderer
    . " all_block_content=" . ($all_block ? 1 : 0) . "\n";
' 2>/dev/null)

echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
