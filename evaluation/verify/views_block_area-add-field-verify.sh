#!/usr/bin/env bash
# Execution VERIFY: PASS when the vba_field_task view has a views_block_field handler (any display)
# rendering the system_branding_block. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $v = \Drupal\views\Entity\View::load("vba_field_task");
  $found = FALSE;
  if ($v) {
    foreach ($v->get("display") as $display) {
      foreach (($display["display_options"]["fields"] ?? []) as $h) {
        if (($h["plugin_id"] ?? "") === "views_block_field" && ($h["block_id"] ?? "") === "system_branding_block") {
          $found = TRUE;
        }
      }
    }
  }
  print ($found ? "PASS" : "FAIL")."\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
