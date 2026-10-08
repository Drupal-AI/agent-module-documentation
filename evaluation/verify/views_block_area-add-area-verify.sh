#!/usr/bin/env bash
# Execution VERIFY: PASS when the vba_task view has a views_block_area handler (any display/region)
# rendering the system_powered_by_block. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $v = \Drupal\views\Entity\View::load("vba_task");
  $found = FALSE;
  if ($v) {
    foreach ($v->get("display") as $display) {
      $opts = $display["display_options"] ?? [];
      foreach (["header","footer","empty"] as $region) {
        foreach ($opts[$region] ?? [] as $h) {
          if (($h["plugin_id"] ?? "") === "views_block_area" && ($h["block_id"] ?? "") === "system_powered_by_block") {
            $found = TRUE;
          }
        }
      }
    }
  }
  print ($found ? "PASS" : "FAIL")."\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
