#!/usr/bin/env bash
# Execution VERIFY: PASS when tac_lite scheme 1 exists but its tac_lite_create form-term
# visibility flag is OFF (falsey). exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $c = \Drupal::config("tac_lite.settings")->get("tac_lite_config_scheme_1");
  $exists = is_array($c);
  $flag = $c["tac_lite_create"] ?? NULL;
  $ok = $exists && empty($flag);
  print ($ok ? "PASS" : "FAIL") . " exists=" . var_export($exists, TRUE) . " tac_lite_create=" . var_export($flag, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q "^PASS" && exit 0 || exit 1
