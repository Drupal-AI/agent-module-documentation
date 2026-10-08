#!/usr/bin/env bash
# Execution VERIFY: PASS when tac_lite scheme 1 grants node view (perms include grant_view),
# accepting either a keyed map or a list. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $c = \Drupal::config("tac_lite.settings")->get("tac_lite_config_scheme_1");
  $perms = (array) ($c["perms"] ?? []);
  $ok = in_array("grant_view", array_values($perms), TRUE) || array_key_exists("grant_view", $perms);
  print ($ok ? "PASS" : "FAIL") . " perms=" . implode("|", array_values($perms)) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q "^PASS" && exit 0 || exit 1
