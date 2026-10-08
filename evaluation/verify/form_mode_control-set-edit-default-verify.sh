#!/usr/bin/env bash
# Execution VERIFY: PASS when defaults.node.article.update.anonymous === 'fmc_task'.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $v = \Drupal::config("form_mode_control.settings")->get("defaults.node.article.update.anonymous");
  $ok = ($v === "fmc_task");
  print ($ok ? "PASS" : "FAIL") . " value=" . var_export($v, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
