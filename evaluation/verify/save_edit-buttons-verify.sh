#!/usr/bin/env bash
# Execution VERIFY: PASS when button_value === 'Save & Continue' AND hide_default_save is truthy.
# exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $c = \Drupal::config("save_edit.settings");
  $bv = $c->get("button_value");
  $hd = $c->get("hide_default_save");
  $ok = ($bv === "Save & Continue") && (bool) $hd;
  print ($ok ? "PASS" : "FAIL") . " button_value=" . var_export($bv, TRUE) . " hide_default_save=" . var_export($hd, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
