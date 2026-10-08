#!/usr/bin/env bash
# Execution VERIFY: PASS when some placed simple_search_form_block has settings
# get_parameter=keys_ssf AND action_path=/ssf-results.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\block\Entity\Block;
  $hit = NULL;
  foreach (Block::loadMultiple() as $b) {
    if ($b->getPluginId() === "simple_search_form_block") {
      $s = $b->get("settings");
      if (($s["get_parameter"] ?? "") === "keys_ssf" && ($s["action_path"] ?? "") === "/ssf-results") {
        $hit = $b->id(); break;
      }
    }
  }
  print ($hit ? "PASS block=$hit" : "FAIL no matching simple_search_form_block") . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
