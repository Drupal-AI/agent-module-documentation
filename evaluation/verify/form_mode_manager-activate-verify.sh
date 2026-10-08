#!/usr/bin/env bash
# Execution VERIFY: PASS when the fmm_task form mode is ACTIVE on node.article, i.e. FMM's
# getActiveDisplays('node') includes 'fmm_task' (a core.entity_form_display.node.article.fmm_task
# config entity exists). exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $active = array_keys(\Drupal::service("form_mode.manager")->getActiveDisplays("node"));
  $ok = in_array("fmm_task", $active, TRUE);
  print ($ok ? "PASS" : "FAIL") . " active_node_modes=" . implode(",", $active) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
