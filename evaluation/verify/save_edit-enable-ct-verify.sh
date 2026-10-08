#!/usr/bin/env bash
# Execution VERIFY: PASS when Save & Edit is enabled for the saveedit_task content type, i.e.
# save_edit.settings.node_types.saveedit_task === 'saveedit_task'. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $nt = \Drupal::config("save_edit.settings")->get("node_types") ?: [];
  $v = $nt["saveedit_task"] ?? NULL;
  $ok = in_array("saveedit_task", array_values($nt), TRUE);
  print ($ok ? "PASS" : "FAIL") . " node_types.saveedit_task=" . var_export($v, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
